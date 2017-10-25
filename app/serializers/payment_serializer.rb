class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :amount
  has_one :item
end
