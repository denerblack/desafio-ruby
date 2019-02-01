class MarketplaceIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }
  define_type Product.all do
    field :id
    field :name
    field :store_name, value: -> (product) { product.store.name }
  end
end
