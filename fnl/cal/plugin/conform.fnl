{1 :stevearc/conform.nvim
 :keys [{1 :<leader>f
         2 (fn []
             ((. (require :conform) :format) {:async true :lsp_format :prefer}))
         :desc "[F]ormat buffer"
         :mode ""}]
 :lazy false
 :opts {:format_on_save (fn [bufnr]
                          (local disable-filetypes {:c true :cpp true})
                          {:lsp_fallback (not (. disable-filetypes
                                                 (. (. vim.bo bufnr) :filetype)))
                           :timeout_ms 500})
        :formatters_by_ft {:lua [:stylua]
                           :markdown [:markdownlint :markdown-toc]
                           :yaml [:yamlfmt :yamlfix]
                           :fennel [:fnlfmt]}
        :notify_on_error false}}
