class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :payments
end
