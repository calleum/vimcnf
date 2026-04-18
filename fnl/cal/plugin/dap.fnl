(local uu (require :cal.util))

(fn setup-dap-ui []
  (let [dap (require :dap)
        dapui (require :dapui)]
    (dapui.setup {:controls {:icons {:disconnect "⏏"
                                     :pause "⏸"
                                     :play "▶"
                                     :run_last "▶▶"
                                     :step_back :b
                                     :step_into "⏎"
                                     :step_out "⏮"
                                     :step_over "⏭"
                                     :terminate "⏹"}}
                  :icons {:collapsed "▸"
                          :current_frame "*"
                          :expanded "▾"}})
    (set dap.listeners.after.event_initialized.dapui_config #(dapui.open))
    (set dap.listeners.before.event_terminated.dapui_config #(dapui.close))
    (set dap.listeners.before.event_exited.dapui_config #(dapui.close))))

(fn set-dap-keymaps []
  (let [dap (require :dap)
        dapui (require :dapui)
        maps [[:<leader>tc dap.continue "Debug: Start/Continue"]
              [:<leader>si dap.step_into "Debug: Step Into"]
              [:<leader>so dap.step_over "Debug: Step Over"]
              [:<leader>su dap.step_out "Debug: Step Out"]
              [:<leader>db dap.toggle_breakpoint "Debug: Toggle Breakpoint"]
              [:<leader>tB #(dap.set_breakpoint (vim.fn.input "Breakpoint condition: ")) "Debug: Set Breakpoint"]
              [:<leader>tt dapui.toggle "Debug: See last session result."]]]
    (each [_ [lhs rhs desc] (ipairs maps)]
      (vim.keymap.set :n lhs rhs {:desc desc}))))

[(uu.tx :mfussenegger/nvim-dap
        {:lazy true
         :dependencies [:rcarriga/nvim-dap-ui
                        :nvim-neotest/nvim-nio
                        :williamboman/mason.nvim
                        :jay-babu/mason-nvim-dap.nvim]
         :config (fn []
                   ((. (require :mason-nvim-dap) :setup) {:automatic_installation true})
                   (setup-dap-ui)
                   (set-dap-keymaps))})]
