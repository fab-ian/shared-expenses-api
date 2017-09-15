class Item < ApplicationRecord
  belongs_to :user
  has_many :item_users
  has_many :users, through: :item_users

  validates :name, presence: true
end
