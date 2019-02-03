class MarketplaceIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      name: {
        tokenizer: 'standard',
				filter: ['standard', 'lowercase','asciifolding' ]#, 'brazilian_stem_filter', 'brazilian_stop']
      }
    }
  }
  define_type Product.all do
    field :id, value: -> (product) { product.id.to_s }
    field :name, analyzer: 'name'
    field :store_name, value: -> (product) { product.store.name }
  end
end
