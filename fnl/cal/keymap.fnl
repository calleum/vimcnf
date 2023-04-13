(module cal.keymap
  {autoload {util cal.util
             nvim aniseed.nvim}})

(defn- map [from to]
  (util.nnoremap from to))


(map :gd "lua vim.lsp.buf.definition()")
(local keymap {})
(fn nmap-mi [keys func desc] (vim.keymap.set :n keys func {: desc}))
(fn tnmap [keys func desc]
  (when desc (set-forcibly! desc (.. "Telescope: " desc)))
  (nmap-mi keys func desc))
(local tele (require :calleum.telescope))
(tnmap :<leader>? (. (require :telescope.builtin) :oldfiles)
       "[?] Find recently opened files")
(tnmap :<leader><space> (. (require :telescope.builtin) :buffers)
       "[ ] Find existing buffers")
(tnmap :<leader>/
       (fn []
         ((. (require :telescope.builtin) :current_buffer_fuzzy_find) ((. (require :telescope.themes)
                                                                          :get_dropdown) {:previewer false
                                                                                                                                                                                                :winblend 10})))
       "[/] Fuzzily search in current buffer]")
(tnmap :<leader>sf tele.project_files "[S]earch [F]iles")
(tnmap :<leader>sh (. (require :telescope.builtin) :help_tags)
       "[S]earch [H]elp")
(tnmap :<leader>sw tele.grep "[S]earch current [W]ord")
(tnmap :<leader>sg tele.live_grep "[S]earch by [G]rep")
(tnmap :<leader>sd (. (require :telescope.builtin) :diagnostics)
       "[S]earch [D]iagnostics")
(tnmap :<leader>fs tele.find_sametype "[F]ind files of [S]ame filetype")
(tnmap :<leader>ai tele.aws_infra_find "Find in [A]ws [I]nfrastructure")
(tnmap :<leader>aj tele.aws_jenkins_find "Find in [A]ws [J]enkins Pipeline")
(tnmap :<leader>dev tele.dev_files_find "Find in [A]ws [I]nfrastructure")
(tnmap :<leader>mkn tele.notes_find "Find in [A]ws [I]nfrastructure")
(tnmap :<leader>qf (. (require :telescope.builtin) :quickfix)
       "Find in [A]ws [I]nfrastructure")
(tnmap :<leader>sc tele.config_find "[S]earch neovim [C]onfiguration files")
(tnmap :<leader>cd (vim.cmd "cd \"%:p:h\"")
       "[C]hange [D]irectory to current file dir")
(tnmap :<leader>st (. (require :telescope.builtin) :tags)
       "[S]earch c[T]ags in project")
(tnmap :<leader>sy (. (require :telescope.builtin)
                      :lsp_dynamic_workspace_symbols)
       "[S]earch Dynamic Workspace S[Y]mbols")
(nmap-mi :<leader>lj (. (require :jenkinsfile_linter) :validate)
         "[L]int [J]enkinsfile")
(nmap-mi :<leader>nd (. (require :neogen) :generate)
         "Generate [N]eogen [D]ocumentation Template")
(nmap-mi :<S-F7> ":%s/\\s\\+$//g<CR>"
         "[<S-F7>] Remove Trailing Whitespace From Lines")
(vim.keymap.set :n :k "v:count == 0 ? 'gk' : 'k'" {:expr true :silent true})
(vim.keymap.set :n :j "v:count == 0 ? 'gj' : 'j'" {:expr true :silent true})
(vim.keymap.set :n :n :nzz {:noremap true :silent true})
(vim.keymap.set :n :N :Nzz {:noremap true :silent true})
(vim.keymap.set :n "*" :*zz {:noremap true :silent true})
(vim.keymap.set :n "#" "#zz" {:noremap true :silent true})
(vim.keymap.set :n :g* :g*zz {:noremap true :silent true})
(vim.keymap.set :n "/" "/\\v" {:noremap true :silent false})
(set keymap.on_attach
     (fn [_ bufnr]
       (fn nmap [keys func desc]
         (when desc (set-forcibly! desc (.. "LSP: " desc)))
         (vim.keymap.set :n keys func {:buffer bufnr : desc}))

       (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
       (nmap :<leader>rn vim.lsp.buf.rename "[R]e[n]ame")
       (nmap :<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction")
       (nmap :gd vim.lsp.buf.definition "[G]oto [D]efinition")
       (nmap :gi vim.lsp.buf.implementation "[G]oto [I]mplementation")
       (nmap :gr (. (require :telescope.builtin) :lsp_references)
             "[G]et [R]eferences")
       (nmap :<leader>si (. (require :telescope.builtin) :lsp_implementations)
             "[S]earch for [I]mplementations")
       (nmap :<leader>ds (. (require :telescope.builtin) :lsp_document_symbols)
             "[D]ocument [S]ymbols")
       (nmap :<leader>ws
             (. (require :telescope.builtin) :lsp_dynamic_workspace_symbols)
             "[W]orkspace [S]ymbols")
       (nmap :K vim.lsp.buf.hover "Hover Documentation")
       (nmap :<C-k> vim.lsp.buf.signature_help "Signature Documentation")
       (nmap :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
       (nmap :<leader>D vim.lsp.buf.type_definition "Type [D]efinition")
       (nmap :<leader>wa vim.lsp.buf.add_workspace_folder
             "[W]orkspace [A]dd Folder")
       (nmap :<leader>wr vim.lsp.buf.remove_workspace_folder
             "[W]orkspace [R]emove Folder")
       (nmap :<leader>wl
             (fn []
               (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
             "[W]orkspace [L]ist Folders")
       (nmap :<leader>e vim.diagnostic.open_float "")
       (nmap "[d" vim.diagnostic.goto_prev "")
       (nmap "]d" vim.diagnostic.goto_next "")
       (nmap :<leader>ql vim.diagnostic.setloclist "")
       (nmap :<leader>f (fn [] (vim.lsp.buf.format {:async true}))
             "Format current buffer with LSP")
       (vim.api.nvim_buf_create_user_command bufnr :Format
                                             (fn [_]
                                               (if vim.lsp.buf.format
                                                   (vim.lsp.buf.format)
                                                   vim.lsp.buf.formatting
                                                   (vim.lsp.buf.formatting)))
                                             {:desc "Format current buffer with LSP"})))
