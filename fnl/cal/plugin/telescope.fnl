(local uu (require :cal.util))
(local tele (require :cal.plugin.tele-custom))

(let [(ok? telescope) (pcall #(require :telescope))]
  (when ok?
    (telescope.setup {:extensions {:ui-select [((. (require :telescope.themes)
                                                               :get_dropdown) {})]}
:defaults {:vimgrep_arguments [:rg
                                                     :--color=never
                                                     :--no-heading
                                                     :--with-filename
                                                     :--line-number
                                                     :--column
                                                     :--smart-case
                                                     :--follow
                                                     :-g
                                                     :!.git/]}})

    (fn tnmap [keys func desc]
      (let [desc (.. "Telescope:" desc)] ; (print (.. desc keys (.. (tostring func))))
        (uu.nmap-mi keys func desc)))

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
    (tnmap :<leader>sw (. (require :telescope.builtin) :grep_string)
           "[S]earch current [W]ord")
    (tnmap :<leader>sg (. (require :telescope.builtin) :live_grep)
           "[S]earch by [G]rep")
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
    (tnmap :<leader>sy
           (. (require :telescope.builtin) :lsp_dynamic_workspace_symbols)
           "[S]earch Dynamic Workspace S[Y]mbols")
    (uu.nmap-mi :<leader>nd (. (require :neogen) :generate)
                "Generate [N]eogen [D]ocumentation Template")
    ))

 ((. (require :telescope) :load_extension) :ui-select)
