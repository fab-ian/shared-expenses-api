class ItemUser < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates_with DoubleItemUserValidator
end
