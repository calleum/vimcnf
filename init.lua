-- local execute = vim.api.nvim_exec
-- local fn = vim.fn
-- local fmt = string.format
-- --
-- local pack_path = fn.stdpath("data") .. "/site/pack"
--
-- function ensure(user, repo)
--     -- Ensures a given github.com/USER/REPO is cloned in the pack/packer/start directory.
--     local install_path = fmt("%s/packer/start/%s", pack_path, repo, repo)
--     if fn.empty(fn.glob(install_path)) > 0 then
--         execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path), {})
--         execute(fmt("packadd %s", repo), {})
--     end
-- end
--
-- ensure("wbthomason", "packer.nvim")
-- -- ensure("Olical", "aniseed")
-- ensure("Olical", "nfnl")
-- ensure("lewis6991", "impatient.nvim")
-- require("impatient")
-- -- vim.g["aniseed#env"] = { module = "cal.init" }
require("cal")

-- require 'calleum'
-- Gitsigns
--[[ require 'gitsigns'.setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' }
    }
} ]]
--
