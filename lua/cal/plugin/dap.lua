-- [nfnl] fnl/cal/plugin/dap.fnl
local uu = require("cal.util")
local function setup_dap_ui()
  local dap = require("dap")
  local dapui = require("dapui")
  dapui.setup({controls = {icons = {disconnect = "\226\143\143", pause = "\226\143\184", play = "\226\150\182", run_last = "\226\150\182\226\150\182", step_back = "b", step_into = "\226\143\142", step_out = "\226\143\174", step_over = "\226\143\173", terminate = "\226\143\185"}}, icons = {collapsed = "\226\150\184", current_frame = "*", expanded = "\226\150\190"}})
  local function _1_()
    return dapui.open()
  end
  dap.listeners.after.event_initialized.dapui_config = _1_
  local function _2_()
    return dapui.close()
  end
  dap.listeners.before.event_terminated.dapui_config = _2_
  local function _3_()
    return dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = _3_
  return nil
end
local function set_dap_keymaps()
  local dap = require("dap")
  local dapui = require("dapui")
  local maps
  local function _4_()
    return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end
  maps = {{"<leader>tc", dap.continue, "Debug: Start/Continue"}, {"<leader>si", dap.step_into, "Debug: Step Into"}, {"<leader>so", dap.step_over, "Debug: Step Over"}, {"<leader>su", dap.step_out, "Debug: Step Out"}, {"<leader>db", dap.toggle_breakpoint, "Debug: Toggle Breakpoint"}, {"<leader>tB", _4_, "Debug: Set Breakpoint"}, {"<leader>tt", dapui.toggle, "Debug: See last session result."}}
  for _, _5_ in ipairs(maps) do
    local lhs = _5_[1]
    local rhs = _5_[2]
    local desc = _5_[3]
    vim.keymap.set("n", lhs, rhs, {desc = desc})
  end
  return nil
end
local function _6_()
  require("mason-nvim-dap").setup({automatic_installation = true})
  setup_dap_ui()
  return set_dap_keymaps()
end
return {uu.tx("mfussenegger/nvim-dap", {lazy = true, dependencies = {"rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "williamboman/mason.nvim", "jay-babu/mason-nvim-dap.nvim"}, config = _6_})}
