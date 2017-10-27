class User < ApplicationRecord
  has_one :credential
  has_many :items
  has_many :item_users
  has_many :users, through: :item_users

  # has_secure_password
  
  validates :name, presence: true

  delegate :email, to: :credential, allow_nil: true
  delegate :password, to: :credential, allow_nil: true
end
