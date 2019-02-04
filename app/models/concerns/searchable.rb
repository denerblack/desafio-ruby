module Searchable
	extend ActiveSupport::Concern

  included do
    def self.search(q:, pagination:)
      query = {
        body: {
          query: {
            query_string: {
              query: "#{q}*"
            }
          }
        }
      }

      query[:body][:from] = pagination[:from]
      query[:body][:size] = pagination[:size]
      result = es_client.search(query)
      ids = result["hits"]["hits"].map { |hits| hits["_source"]["id"] }
      objects = Product.where(:id.in => ids)
      OpenStruct.new(collection: objects.size == 0 ? [] : objects, total: result["hits"]["total"])
    end

    def self.es_client
      "MarketplaceIndex::#{self.name}".constantize.client
    end
  end
end
