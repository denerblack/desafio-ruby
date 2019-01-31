require 'chewy'

class Product

  include Mongoid::Document
  include Mongoid::Timestamps

  update_index('marketplace#product') { self }

  field :name, type: String
  field :price, type: Float
  field :image, type: String
  field :url, type: String

  belongs_to :store

  embeds_many :installments

end
