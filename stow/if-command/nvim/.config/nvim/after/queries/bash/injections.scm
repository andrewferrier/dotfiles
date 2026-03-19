;; extends

; Highlight alias values as bash (single-quoted: alias x='...')
((command
  name: (command_name) @_cmd (#eq? @_cmd "alias")
  argument: (concatenation
    (raw_string) @injection.content))
 (#set! injection.language "bash")
 (#offset! @injection.content 0 1 0 -1))

; Highlight alias values as bash (double-quoted: alias x="...")
((command
  name: (command_name) @_cmd (#eq? @_cmd "alias")
  argument: (concatenation
    (string
      (string_content) @injection.content)))
 (#set! injection.language "bash"))
