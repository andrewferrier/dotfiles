all
rule 'MD003', :style => :atx
rule 'MD007', :indent => 4
rule 'MD026', :punctuation => '.,:;'
rule 'MD029', :style => :one_or_ordered
rule 'MD046', :style => :consistent
exclude_rule 'MD009' # use null_ls instead, it's more accurate
exclude_rule 'MD013'
exclude_rule 'MD024' # it is valid to have multiple headers with the same content in multiple sections!
exclude_rule 'MD025' # in documents with frontmatter, multiple top-level headers are fine
exclude_rule 'MD030' # not currently possible to ask markdownlint to check for consistent lists
exclude_rule 'MD033'
exclude_rule 'MD041' # it is not necessarily true that the first line should be top-level, e.g. frontmatter
