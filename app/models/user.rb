class User < ApplicationRecord
  has_secure_password

  has_many :items
  has_many :item_users
  has_many :users, through: :item_users

  validates :name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
end
