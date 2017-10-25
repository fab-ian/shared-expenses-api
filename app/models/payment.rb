class Payment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  
  validates :name, presence: true  
  validates :amount, presence:true, numericality: { only_integer: true }
end
