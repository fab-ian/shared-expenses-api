class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :amount
  has_one :item
  has_one :user
end
