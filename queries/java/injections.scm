((block_comment) @injection.content
  (#set! injection.include-children )
  (#set! injection.self )
  (#match? @injection.content "/\\*-\\{")
  (#match? @injection.content "\\}-\\*/")
  (#offset! @injection.content 0 4 0 -4)
  (#set! injection.language "javascript"))
