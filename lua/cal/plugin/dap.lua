-- [nfnl] Compiled from fnl/cal/plugin/dap.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("cal.util")
local function _1_()
  local dap = require("dap")
  local dapui = require("dapui")
  do end (require("mason-nvim-dap")).setup({automatic_installation = true, ensure_installed = {}, handlers = {}})
  vim.keymap.set("n", "<leader>tc", dap.continue, {desc = "Debug: Start/Continue"})
  vim.keymap.set("n", "<leader>si", dap.step_into, {desc = "Debug: Step Into"})
  vim.keymap.set("n", "<leader>so", dap.step_over, {desc = "Debug: Step Over"})
  vim.keymap.set("n", "<leader>su", dap.step_out, {desc = "Debug: Step Out"})
  vim.keymap.set("n", "<leader>tb", dap.toggle_breakpoint, {desc = "Debug: Toggle Breakpoint"})
  local function _2_()
    return dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end
  vim.keymap.set("n", "<leader>tB", _2_, {desc = "Debug: Set Breakpoint"})
  dapui.setup({controls = {icons = {disconnect = "\226\143\143", pause = "\226\143\184", play = "\226\150\182", run_last = "\226\150\182\226\150\182", step_back = "b", step_into = "\226\143\142", step_out = "\226\143\174", step_over = "\226\143\173", terminate = "\226\143\185"}}, icons = {collapsed = "\226\150\184", current_frame = "*", expanded = "\226\150\190"}})
  vim.keymap.set("n", "<leader>tt", dapui.toggle, {desc = "Debug: See last session result."})
  do end (dap.listeners.after.event_initialized)["dapui_config"] = dapui.open
  dap.listeners.before.event_terminated["dapui_config"] = dapui.close
  dap.listeners.before.event_exited["dapui_config"] = dapui.close
  return nil
end
return {uu.tx("mfussenegger/nvim-dap", {config = _1_, lazy = true, dependencies = {"rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "williamboman/mason.nvim", "jay-babu/mason-nvim-dap.nvim"}})}
