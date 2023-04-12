local execute = vim.api.nvim_exec
local fn = vim.fn
local fmt = string.format

local pack_path = fn.stdpath("data") .. "/site/pack"

function ensure(user, repo)
    -- Ensures a given github.com/USER/REPO is cloned in the pack/packer/start directory.
    local install_path = fmt("%s/packer/start/%s", pack_path, repo, repo)
    if fn.empty(fn.glob(install_path)) > 0 then
        execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path), {})
        execute(fmt("packadd %s", repo), {})
    end
end

ensure("wbthomason", "packer.nvim")

-- Aniseed compiles our Fennel code to Lua and loads it automatically.
ensure("Olical", "aniseed")

-- Enable Aniseed's automatic compilation and loading of Fennel source code.
vim.g["aniseed#env"] = { module = "cal.init" }

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
} ]]--


