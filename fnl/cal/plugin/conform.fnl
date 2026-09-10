(local uu (require :cal.util))

(fn find-remove-unused-imports [actions]
  (var found nil)
  (each [_ action (ipairs actions)]
    (when (and (not found) action.data
               (string.match (or action.data.id "") :^remove_unused_imports))
      (set found action)))
  found)

(fn rust-remove-unused-imports [bufnr]
  "rust-analyzer advertises no source.organizeImports. Its remove_unused_imports
  assist is a quickfix that it only offers when the requested range spans the
  use items, so the request covers the whole buffer."
  (let [[client] (vim.lsp.get_clients {: bufnr :name :rust_analyzer})]
    (when client
      (let [last-line (math.max 0 (- (vim.api.nvim_buf_line_count bufnr) 1))
            params {:textDocument (vim.lsp.util.make_text_document_params bufnr)
                    :range {:start {:line 0 :character 0}
                            :end {:line last-line :character 0}}
                    :context {:diagnostics {} :only [:quickfix]}}
            response (client:request_sync :textDocument/codeAction params 1000
                                          bufnr)
            action (find-remove-unused-imports (or (?. response :result) []))]
        (when action
          (let [resolved (or (?. (client:request_sync :codeAction/resolve
                                                      action 1000 bufnr)
                                 :result) action)]
            (when resolved.edit
              (vim.lsp.util.apply_workspace_edit resolved.edit
                                                 client.offset_encoding))))))))

(fn organize-imports [bufnr]
  (when (= (. vim.bo bufnr :filetype) :rust)
    (rust-remove-unused-imports bufnr)))

(fn format-buffer []
  (organize-imports (vim.api.nvim_get_current_buf))
  ((. (require :conform) :format) {:async true :lsp_format :fallback}))

;; Dropping an import leaves `use a::{b};`, which only rustfmt tidies, so the
;; assist has to run before the formatter rather than in its own BufWritePre.
(fn format-on-save [bufnr]
  (organize-imports bufnr)
  {:lsp_format :fallback :timeout_ms 500})

[(uu.tx :stevearc/conform.nvim
        {:lazy false
         :keys [(uu.tx :<leader>f format-buffer {:desc "[F]ormat buffer"})]
         :opts {:format_on_save format-on-save
                :formatters_by_ft {:lua [:stylua]
                                   :rust [:injected :rustfmt]
                                   :sql [:sqlfmt]
                                   :vue [:eslint_d]
                                   :make [:bake]
                                   :bash [:shfmt]
                                   :sh [:shfmt]
                                   :json [:jq]
                                   :latex [:tex-fmt]
                                   :fennel [:fnlfmt]
                                   :nix [:nixfmt]
                                   :python [:black]}}})]
