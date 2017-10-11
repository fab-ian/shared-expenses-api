class Item < ApplicationRecord
  belongs_to :user
  has_many :item_users
  has_many :users, through: :item_users
  has_many :payments

  validates :name, presence: true
end
