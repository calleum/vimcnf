(local uu (require :cal.util))
[(uu.tx :greggh/claude-code.nvim
        {:config (fn []
                   (local claude (require :claude-code))
                   (claude.setup {:command "AWS_REGION=us-east-1 claude"})
                   (vim.keymap.set :n :<leader>cc :<cmd>ClaudeCode<CR>
                                   {:desc "Toggle [C]laude [C]ode"})
                   ; (map :<leader>cc :<cmd>ClaudeCode<CR> ;      "Toggle [C]laude [C]ode")
                   )
         :dependencies [:nvim-lua/plenary.nvim]})]
