(local uu (require :cal.util))

(fn generate-doc []
  ((. (require :neogen) :generate)))

[(uu.tx :danymat/neogen
        {:keys [(uu.tx :<leader>nd generate-doc {:desc "Generate Annotation"})]
         :config (fn []
                   ((. (require :neogen) :setup) {:snippet_engine :luasnip}))})]
