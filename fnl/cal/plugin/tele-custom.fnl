(local M {})
(set M.project_files
     (fn [opts]
       (let [ok (pcall (. (require :telescope.builtin) :git_files) opts)]
         (when (not ok)
           ((. (require :telescope.builtin) :find_files) opts)))))
(local actions (require :telescope.actions))
(local action-state (require :telescope.actions.state))
(fn run-selection [prompt-bufnr map]
  (actions.select_default:replace (fn []
                                    (actions.close prompt-bufnr)
                                    (local selection
                                           (action-state.get_selected_entry))
                                    (vim.cmd (.. "!git log " (. selection 1)))))
  true)
(set M.git_log
     (fn []
       (let [opts {:attach_mappings run-selection}]
         ((. (require :telescope.builtin) :find_files) opts))))
(fn M.find_sametype []
  (let [my-filetype (vim.fn.expand "%:e")
        opts {:find_command [:fd
                             :--type
                             :f
                             :-e
                             my-filetype
                             :--strip-cwd-prefix]
              :layout_strategy :horizontal
              :prompt_title (.. "[Find in same filetype: " my-filetype "]")
              :shorten_path false}]
    ((. (require :telescope.builtin) :find_files) opts)))
(fn M.protecht_find []
  (let [opts {:cwd "~/Documents/protecht/"
              :layout_strategy :horizontal
              :prompt_title "[Find In ~/Documents/protecht]"
              :shorten_path true}]
    ((. (require :telescope.builtin) :find_files) opts)))
(fn M.aws_jenkins_find []
  (let [opts {:cwd "~/src/uni/"
              :layout_strategy :horizontal
              :prompt_title "[Find In ~/src/uni]"
              :shorten_path false}]
    (M.project_files opts)))
(fn M.aws_infra_find []
  (let [opts {:cwd "~/Documents/protecht/aws-infrastructure/"
              :layout_strategy :horizontal
              :prompt_title "~ aws-infra ~"
              :shorten_path false}]
    (M.project_files opts)))
(fn M.dev_files_find []
  (let [opts {:cwd "~/src/"
              :layout_strategy :horizontal
              :prompt_title "[Find In ~/src]"
              :shorten_path false}]
    (M.project_files opts)))
(fn M.config_find []
  (let [opts {:cwd "~/.config/nvim/"
              :layout_strategy :horizontal
              :prompt_title "[Find In ~/.config/nvim/]"
              :shorten_path false}]
    (M.project_files opts)))
(fn M.notes_find []
  (let [opts {:cwd "~/src/notes/"
              :layout_strategy :horizontal
              :prompt_title "[Find In ~/src/notes]"
              :shorten_path false
              :sorting_strategy :ascending}]
    (M.project_files opts)))
M
