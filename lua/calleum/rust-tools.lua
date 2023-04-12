local rust_dir = vim.fn.getenv 'HOME' .. '/src/rust'
local rt = require("rust-tools")
local rt_on_attach = function(_, bufnr)
    -- Call the generic on_attach, then add the rust-specific keymaps
    require('calleum.keymap').on_attach(_, bufnr)

    local opts = { buffer = bufnr }
    -- Hover actions
    vim.keymap.set("n", "K", rt.hover_actions.hover_actions, opts)
    -- Code action groups
    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, opts)
    vim.keymap.set("n", "<Leader>ru", rt.runnables.runnables, opts)
end

local rt_opts = {
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = false,
            disable = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        standalone = false,
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = rt_on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- rustfmt = {
                --     overrideCommand = {
                --         rust_dir .. "/build/host/rustfmt/bin/rustfmt",
                --         "--edition=2021"
                --     }
                -- },
                -- procMacro = {
                --     server = rust_dir .. "/build/host/stage0/libexec/rust-analyzer-proc-macro-srv",
                --     enable = true,
                -- },
                -- rustc = {
                --     source = rust_dir .. "/Cargo.toml",
                -- },
                -- -- enable clippy on save
                -- checkOnSave = {
                --     overrideCommand = { "python3",
                --         "x.py",
                --         "check",
                --         "--build-dir build-rust-analyzer",
                --         "--json-output"
                --     },
                -- },
                -- cargo = {
                --     allFeatures = true,
                --     sysroot = rust_dir .. "/build/host/stage0-sysroot",
                --     buildScripts = {
                --         invocationLocation = "root",
                --         invocationStrategy = "once",
                --         overrideCommand = {
                --         rust_dir .. "/build/host/rustfmt/bin/rustfmt",
                --         "--edition=2021"
                --         }
                --     },
                -- },
                diagnostics = {
                    enable = true,
                    experimental = {
                        enable = true
                    },
                },
            },
        },
    },
}

rt.setup(rt_opts)

rt.inlay_hints.disable()
