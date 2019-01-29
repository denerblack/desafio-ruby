class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: NumberDecimal
  field :image, type: String
  field :url, type: String

  embeds_many :installments

end
