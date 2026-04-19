(local fun (require :cal.util.vendor.fun))

(fn pretty-print-table [t ?indent-arg]
  "Pretty print a table with indentation."
  (let [indent (or ?indent-arg 0)
        toprint (.. (string.rep " " indent) "{\n")
        new-indent (+ indent 2)]
    (let [lines (icollect [k v (pairs t)]
                  (let [k-str (match (type k)
                                :number (.. "[" k "]")
                                :string k
                                _ (tostring k))
                        v-str (match (type v)
                                :number (tostring v)
                                :string (.. "\"" v "\"")
                                :table (pretty-print-table v (+ new-indent 2))
                                _ (.. "\"" (tostring v) "\""))]
                    (.. (string.rep " " new-indent) k-str "= " v-str ",")))]
      (.. toprint (table.concat lines "\n") "\n" (string.rep " " indent) "}"))))

(fn last [xs]
  "Return the last element of a sequential table."
  (fun.nth (fun.length xs) xs))

(fn reverse [xs]
  "Reverse a sequential table."
  (let [len (fun.length xs)]
    (fun.take len (fun.tabulate (fn [n]
                                  (fun.nth (- len n) xs))))))

(fn view [list]
  "Return a string representation of a list."
  (table.concat (icollect [_ val (ipairs list)] (.. "[" val "]")) " | "))

(fn tx [...]
  "Slightly nicer syntax for things like defining dependencies.
  Anything that relies on the {1 :foo :bar true} syntax can use this."
  (let [args [...]
        len (fun.length args)
        last-arg (last args)]
    (match (type last-arg)
      :table (fun.reduce (fn [acc n v]
                           (tset acc n v)
                           acc) last-arg
                         (fun.zip (fun.range 1 len) (fun.take (- len 1) args)))
      _ args)))

(fn extend-or-override [config custom ...]
  "Extend or override a configuration table."
  (match (type custom)
    :function (or (custom config ...) config)
    :table (vim.tbl_deep_extend :force config custom)
    _ custom))

{: tx : last : reverse : extend-or-override : pretty-print-table : view}
