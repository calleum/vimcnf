; Treesitter injection for LaTeX lstlisting environments
; Enables syntax highlighting for code blocks with language parameters
; Usage: \begin{lstlisting}[language=Python]...\end{lstlisting}

; Python
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Pp]ython")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "python"))

; Java
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Jj]ava")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "java"))

; JavaScript
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Jj]ava[Ss]cript")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "javascript"))

; TypeScript
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Tt]ype[Ss]cript")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "typescript"))

; C
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Cc][^%+%w]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "c"))

; C++
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Cc]%+%+")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "cpp"))

; Rust
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Rr]ust")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "rust"))

; Go
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Gg]o[^%w]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "go"))

; Bash/Shell
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Bb]ash")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "bash"))

; SQL
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Ss][Qq][Ll]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "sql"))

; HTML
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Hh][Tt][Mm][Ll]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "html"))

; CSS
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Cc][Ss][Ss]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "css"))

; Lua
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Ll]ua")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "lua"))

; Ruby
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Rr]uby")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "ruby"))

; PHP
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Pp][Hh][Pp]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "php"))

; Swift
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Ss]wift")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "swift"))

; Kotlin
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Kk]otlin")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "kotlin"))

; JSON
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Jj][Ss][Oo][Nn]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "json"))

; YAML
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Yy][Aa][Mm][Ll]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "yaml"))

; TOML
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Tt]oml")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "toml"))

; XML
((listing_environment
  code: (source_code) @injection.content)
  (#lua-match? @injection.content "language%s*=%s*[Xx][Mm][Ll]")
  (#offset! @injection.content 0 1 0 0)
  (#set! injection.language "xml"))

; Fallback for lstlisting without language parameter
((listing_environment
  code: (source_code) @injection.content)
  (#set! injection.language "text"))
