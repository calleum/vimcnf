(local fun (require :cal.util.vendor.fun))
(local vim _G.vim)

(fn get [t k d]
  (let [res (when (= (type t) :table)
              (let [val (. t k)]
                (when (not (= nil val))
                  val)))]
    (if (= nil res)
        d
        res)))

(fn remap [from to opts]
  (let [map-opts {:noremap true}]
    (. (extend-or-override opts {:callback to}))
    (if (get opts :local?)
        ((vim.keymap.set 0 :n from to map-opts))
        (vim.keymap.set :n from to map-opts))))

(fn nnoremap [from to opts]
  (remap from to opts))

(fn nmap-ni [keys func desc] (vim.keymap.set :n keys func {: desc}))

(fn lnnoremap [from to]
  (nnoremap (.. :<leader> from) to))

(fn autoload [name]
  "Like autoload from Vim Script! A replacement for require that will load the
  module when you first use it. Use it in Aniseed module macros with:

  (module foo {autoload {foo x.y.foo}})

  It's a drop in replacement for require that should speed up your Neovim
  startup dramatically. Only works with table modules, if the module you're
  requiring is a function etc you need to use the normal require.
  
  Copied from https://github.com/Olical/aniseed"
  (let [res {:aniseed/autoload-enabled? true :aniseed/autoload-module false}]
    (fn ensure []
      (if (. res :aniseed/autoload-module)
          (. res :aniseed/autoload-module)
          (let [m (require name)]
            (tset res :aniseed/autoload-module m)
            m)))

    (setmetatable res
                  {:__call (fn [_t ...]
                             ((ensure) ...))
                   :__index (fn [_t k]
                              (. (ensure) k))
                   :__newindex (fn [_t k v]
                                 (tset (ensure) k v))})))

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

(fn dev? [plugin-name]
  "Do we have a repo cloned at the expected location? If so we can tell lazy to load that rather than install it from GitHub."
  (= 1
     (vim.fn.isdirectory (.. (vim.fn.expand "~/repos/Olical") "/" plugin-name))))

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

(fn safe-require-plugin-config [name]
  "Safely require a module under the cal.plugin.* prefix. Will catch errors
  and print them while continuing execution, allowing other plugins to load
  even if one configuration module is broken."
  (let [(ok? val-or-err) (pcall require (.. :cal.plugin. name))]
    (when (not ok?)
      (print (.. "Plugin config error: " val-or-err)))))

(fn req [name]
  "A shortcut to building a require string for your plugin
  configuration. Intended for use with packer's config or setup
  configuration options. Will prefix the name with `cal.plugin.`
  before requiring."
  (.. "require('cal.plugin." name "')"))

{: autoload
 : dev?
 : tx
 : last
 : reverse
 : expand
 : glob
 : exists?
 : lua-file
 : nnoremap
 : lnnoremap
 : remap
 : pretty-print-table
 : extend-or-override}

; : calnnoremap

