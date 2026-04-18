(local uu (require :cal.util))

(fn setup-telescope []
  (let [telescope (require :telescope)
        themes (require :telescope.themes)]
    (telescope.setup {:extensions {:ui-select [(themes.get_dropdown {:layout_config {:width 0.9}})]}})
    (each [_ ext (ipairs [:fzf :ui-select :dap])]
      (pcall telescope.load_extension ext))))

(fn set-telescope-keymaps []
  (let [builtin (require :telescope.builtin)
        themes (require :telescope.themes)
        maps [[:<leader>sh builtin.help_tags "Search Help"]
              [:<leader>sm builtin.man_pages "Search Man Pages"]
              [:<leader>sk builtin.keymaps "Search Keymaps"]
              [:<leader>sf builtin.find_files "Search Files"]
              [:<leader>sw builtin.grep_string "Search current Word"]
              [:<leader>sg builtin.live_grep "Search by Grep"]
              [:<leader>sd builtin.diagnostics "Search Diagnostics"]
              [:<leader>sr builtin.resume "Search References"]
              [:<leader>s. builtin.oldfiles "Search Recent Files (\".\" for repeat)"]
              [:<leader><leader> builtin.buffers "[ ] Find existing buffers"]
              [:<leader>/
               #(builtin.current_buffer_fuzzy_find (themes.get_dropdown {:previewer false :winblend 10}))
               "[/] Fuzzily search in current buffer"]
              [:<leader>s/
               #(builtin.live_grep {:grep_open_files true :prompt_title "Live Grep in Open Files"})
               "Search [/] in Open Files"]
              [:<leader>ss
               #(builtin.find_files {:cwd (vim.fn.expand "~/.config/fish")})
               "Search Fish files"]
              [:<leader>sn
               #(builtin.find_files {:cwd (vim.fn.stdpath :config)})
               "Search Neovim files"]]]
    (each [_ [lhs rhs desc] (ipairs maps)]
      (vim.keymap.set :n lhs rhs {:desc desc}))))

[(uu.tx :nvim-telescope/telescope.nvim
        {:branch :master
         :event :VimEnter
         :config (fn []
                   (setup-telescope)
                   (set-telescope-keymaps))
         :dependencies [:nvim-lua/plenary.nvim
                        (uu.tx :nvim-telescope/telescope-dap.nvim {:lazy true})
                        (uu.tx :nvim-telescope/telescope-fzf-native.nvim
                               {:build :make
                                :cond #(= (vim.fn.executable :make) 1)})
                        (uu.tx :nvim-telescope/telescope-ui-select.nvim)
                        :nvim-tree/nvim-web-devicons]})]
