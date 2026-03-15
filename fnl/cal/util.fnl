(local fun (require :cal.util.vendor.fun))

(fn pretty-print-table [t indent-arg]
  (var indent (or indent-arg 0))
  (var toprint (.. (string.rep " " indent) "{\n"))
  (set indent (+ indent 2))
  (each [k v (pairs t)]
    (set toprint (.. toprint (string.rep " " indent)))
    (if (= (type k) :number) (set toprint (.. toprint "[" k "] = "))
        (= (type k) :string) (set toprint (.. toprint k "= ")))
    (if (= (type v) :number) (set toprint (.. toprint v ",\n"))
        (= (type v) :string) (set toprint (.. toprint "\"" v "\",\n"))
        (= (type v) :table) (set toprint
                                 (.. toprint
                                     (pretty-print-table v (+ indent 2)) ",\n"))
        (set toprint (.. toprint "\"" (tostring v) "\",\n"))))
  (set toprint (.. toprint (string.rep " " (- indent 2)) "}"))
  toprint)

(fn last [xs]
  (fun.nth (fun.length xs) xs))

(fn reverse [xs]
  (let [len (fun.length xs)]
    (fun.take (fun.length xs)
              (fun.tabulate (fn [n]
                              (fun.nth (- len n) xs))))))

(fn tx [...]
  "Slightly nicer syntax for things like defining dependencies.
  Anything that relies on the {1 :foo :bar true} syntax can use this."
  (let [args [...]
        len (fun.length args)]
    (if (= :table (type (last args)))
        (fun.reduce (fn [acc n v]
                      (tset acc n v)
                      acc) (last args)
                    (fun.zip (fun.range 1 len) (fun.take (- len 1) args)))
        args)))

(fn extend-or-override [config custom ...]
  (var new-config nil)
  (if (= (type custom) :function)
      (set new-config (or (custom config ...) config))
      custom
      (set new-config (vim.tbl_deep_extend :force config custom)))
  new-config)

{: tx
 : last
 : reverse
 : extend-or-override
 : pretty-print-table}
