-- [nfnl] fnl/cal/plugin/jenkins.fnl
local uu = require("cal.util")
local function _1_()
  local jenkins_linter = require("jenkinsfile_linter")
  return vim.keymap.set("n", "<leader>lj", jenkins_linter.validate, {})
end
return {uu.tx("ckipp01/nvim-jenkinsfile-linter", {config = _1_})}
