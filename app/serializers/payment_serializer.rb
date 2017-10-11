class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_one :item
end
