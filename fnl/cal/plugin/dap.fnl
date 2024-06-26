(local uu (require :cal.util))
(local nvim (uu.autoload :aniseed.nvim))

(local dap (require :dap))
(local dapui (require :dapui))
((. (require :mason-nvim-dap) :setup) {:automatic_installation true
                                       :ensure_installed {}
                                       :handlers {}})

(dapui.setup {:controls {:icons {:disconnect "⏏"
                                 :pause "⏸"
                                 :play "▶"
                                 :run_last "▶▶"
                                 :step_back :b
                                 :step_into "⏎"
                                 :step_out "⏮"
                                 :step_over "⏭"
                                 :terminate "⏹"}}
              :icons {:collapsed "▸" :current_frame "*" :expanded "▾"}})

(nvim.set_keymap :n :<F7> dapui.toggle
                 {:desc "Debug: See last session result."})

(tset dap.listeners.after.event_initialized :dapui_config dapui.open)
(tset dap.listeners.before.event_terminated :dapui_config dapui.close)
(tset dap.listeners.before.event_exited :dapui_config dapui.close)
