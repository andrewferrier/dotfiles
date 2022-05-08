all
rule 'MD003', :style => :atx
rule 'MD007', :indent => 4
rule 'MD026', :punctuation => '.,:;'
rule 'MD029', :style => :one_or_ordered
rule 'MD030', :ul_multi => 3, :ul_single => 3, :ol_multi => 2, :ol_single => 2
rule 'MD046', :style => :consistent
exclude_rule 'MD013'
exclude_rule 'MD024' # it is valid to have multiple headers with the same content in multiple sections!
exclude_rule 'MD033'
