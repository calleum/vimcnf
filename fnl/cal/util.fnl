(local a (require :aniseed.core))
(local nvim (require :aniseed.nvim))
(local fun (require :cal.util.vendor.fun))
(local config-path (nvim.fn.stdpath :config))
(local vim _G.vim)

(fn expand [path]
  (nvim.fn.expand path))

(fn glob [path]
  (nvim.fn.glob path true true true))

(fn exists? [path]
  (= (nvim.fn.filereadable path) 1))

(fn lua-file [path]
  (nvim.ex.luafile path))

(fn remap [from to opts]
  (let [map-opts (a.merge opts {:noremap true})]
  (. (a.merge! opts {:callback to}))
    (if (a.get opts :local?)
        ((if (= (type arg) :function)
             ) (vim.keymap.set 0 :n from to
                                                                 map-opts))
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

{: autoload
 : dev?
 : tx
 : last
 : reverse
 : expand
 : glob
 : exists?
 : lua-file
 : config-path
 : nnoremap
 : lnnoremap
 : remap
 : nmap-mi}

; : calnnoremap
