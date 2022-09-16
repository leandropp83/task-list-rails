STATUS = {:ativo => 1, :inativo => 0}.freeze
ORDER_BY = {
    1 => { :value => { created_at: :desc}, :label => "Data - Decrescente"},
    2 => { :value => { created_at: :asc}, :label => "Data - Crescente"}
}.stringify_keys.freeze