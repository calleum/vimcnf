local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

-- complicated function for dynamicNode.
local function jdocsnip(args, _, old_state)
	-- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
	-- Using a restoreNode instead is much easier.
	-- View this only as an example on how old_state functions.
	local nodes = {
		t({ "/**", " * " }),
		i(1, "A short Description"),
		t({ "", "" }),
	}

	-- These will be merged with the snippet; that way, should the snippet be updated,
	-- some user input eg. text can be referred to in the new snippet.
	local param_nodes = {}

	if old_state then
		nodes[2] = i(1, old_state.descr:get_text())
	end
	param_nodes.descr = nodes[2]

	-- At least one param.
	if string.find(args[2][1], ", ") then
		vim.list_extend(nodes, { t({ " * ", "" }) })
	end

	local insert = 2
	for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
		-- Get actual name parameter.
		arg = vim.split(arg, " ", true)[2]
		if arg then
			local inode
			-- if there was some text in this parameter, use it as static_text for this new snippet.
			if old_state and old_state[arg] then
				inode = i(insert, old_state["arg" .. arg]:get_text())
			else
				inode = i(insert)
			end
			vim.list_extend(nodes, { t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) })
			param_nodes["arg" .. arg] = inode

			insert = insert + 1
		end
	end

	if args[1][1] ~= "void" then
		local inode
		if old_state and old_state.ret then
			inode = i(insert, old_state.ret:get_text())
		else
			inode = i(insert)
		end

		vim.list_extend(nodes, { t({ " * ", " * @return " }), inode, t({ "", "" }) })
		param_nodes.ret = inode
		insert = insert + 1
	end

	if vim.tbl_count(args[3]) ~= 1 then
		local exc = string.gsub(args[3][2], " throws ", "")
		local ins
		if old_state and old_state.ex then
			ins = i(insert, old_state.ex:get_text())
		else
			ins = i(insert)
		end
		vim.list_extend(nodes, { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) })
		param_nodes.ex = ins
		insert = insert + 1
	end

	vim.list_extend(nodes, { t({ " */" }) })

	local snip = sn(nil, nodes)
	-- Error on attempting overwrite.
	snip.old_state = param_nodes
	return snip
end

ls.add_snippets("java", {
	-- Very long example for a java class.
	s("fn", {
		d(6, jdocsnip, { 2, 4, 5 }),
		t({ "", "" }),
		c(1, {
			t("public "),
			t("private "),
		}),
		c(2, {
			t("void"),
			t("String"),
			t("char"),
			t("int"),
			t("double"),
			t("boolean"),
			i(nil, ""),
		}),
		t(" "),
		i(3, "myFunc"),
		t("("),
		i(4),
		t(")"),
		c(5, {
			t(""),
			sn(nil, {
				t({ "", " throws " }),
				i(1),
			}),
		}),
		t({ " {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),
}, {
	key = "java",
})
local ts_utils = require("nvim-treesitter.ts_utils")
local function ts_log_choice(_, _snip)
	local bufnr = vim.api.nvim_get_current_buf()
	-- 1) Find the enclosing method node
	-- start at cursor, walk up to the nearest method_declaration
	local node = ts_utils.get_node_at_cursor()
	while node and node:type() ~= "method_declaration" do
		node = node:parent()
	end
	-- fallback if we're not in a method
	if not node then
		return sn(nil, { t('LOG.severe("");') })
	end

	-- 2) Ascend to the class_declaration
	local class_node = node
	while class_node and class_node:type() ~= "class_declaration" do
		class_node = class_node:parent()
	end

	-- 3) Scan for a Logger field: default to 'log'
	local logger_var = "log"
	if class_node then
		for field in class_node:iter_children() do
			if field:type() == "field_declaration" then
				-- grab the type name
				local type_node = field:field("type")[1]
				local type_name = type_node and ts_utils.get_node_text(type_node)[1] or ""
				if type_name:match("Logger$") then
					-- grab the variable declarator's name
					local decl = field:field("variable_declarator")[1]
					local name_node = decl and decl:field("name")[1]
					if name_node then
						logger_var = ts_utils.get_node_text(name_node)[1]
						break
					end
				end
			end
		end
	end
	-- extract method name
	local name_node = node:field("name")[1]
	local method_name = vim.treesitter.get_node_text(name_node, bufnr)

	-- extract parameter identifiers
	local params = {}
	local params_node = node:field("parameters")[1]
	if params_node then
		for child in params_node:iter_children() do
			if child:type() == "formal_parameter" then
				-- within each parameter, pick the first identifier child
				for id in child:iter_children() do
					if id:type() == "identifier" then
						table.insert(params, vim.treesitter.get_node_text(id, bufnr))
						break
					end
				end
			end
		end
	end

	-- build the LOG.severe string
	local parts = {}
	for _, var in ipairs(params) do
		table.insert(parts, var .. '=[" + ' .. var .. ' + "]')
	end
	local levels = { "severe", "warning", "info", "fine", "error", "debug" }
	local log_prefix = logger_var .. "."

	-- return a snippet node combining text + choice:
	return sn(nil, {
		t(log_prefix),
		t("severe"),
		-- c(2, { t("severe"), t("warning"), t("info"), t("fine"), t("error"), t("debug") }),
		t('("' .. method_name .. (next(parts) and (": " .. table.concat(parts, ", ")) or "") .. '");'),
	})
	-- local content
	-- -- 5) Build the final snippet text
	-- local log_call = logger_var
	-- 	.. '.severe("'
	-- 	.. method_name
	-- 	.. (next(parts) and (": " .. table.concat(parts, ", ")) or "")
	-- 	.. '");'
	-- return sn(nil, { t(content) })
end
ls.add_snippets("java", {
	s("logm", {
		d(1, ts_log_choice, {}),
	}),
})
