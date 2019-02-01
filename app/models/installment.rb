class Installment
  include Mongoid::Document
  field :value, type: Float
  field :number_of_installments, type: Integer

  embedded_in :product
end
