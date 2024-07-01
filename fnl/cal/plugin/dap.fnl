(local uu (require :cal.util))

[(uu.tx :mfussenegger/nvim-dap
        {:config (fn []
                   (local dap (require :dap))
                   (local dapui (require :dapui))
                   ((. (require :mason-nvim-dap) :setup) {:automatic_installation true
                                                          :ensure_installed {}
                                                          :handlers {}})
                   (vim.keymap.set :n :<leader>tc dap.continue
                                   {:desc "Debug: Start/Continue"})
                   (vim.keymap.set :n :<leader>si dap.step_into
                                   {:desc "Debug: Step Into"})
                   (vim.keymap.set :n :<leader>so dap.step_over
                                   {:desc "Debug: Step Over"})
                   (vim.keymap.set :n :<leader>su dap.step_out
                                   {:desc "Debug: Step Out"})
                   (vim.keymap.set :n :<leader>tb dap.toggle_breakpoint
                                   {:desc "Debug: Toggle Breakpoint"})
                   (vim.keymap.set :n :<leader>tB
                                   (fn []
                                     (dap.set_breakpoint (vim.fn.input "Breakpoint condition: ")))
                                   {:desc "Debug: Set Breakpoint"})
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
                   (vim.keymap.set :n :<leader>tt dapui.toggle
                                   {:desc "Debug: See last session result."})
                   (tset dap.listeners.after.event_initialized :dapui_config
                         dapui.open)
                   (tset dap.listeners.before.event_terminated :dapui_config
                         dapui.close)
                   (tset dap.listeners.before.event_exited :dapui_config
                         dapui.close))
         :dependencies [:rcarriga/nvim-dap-ui
                        :nvim-neotest/nvim-nio
                        :williamboman/mason.nvim
                        :jay-babu/mason-nvim-dap.nvim]})]
