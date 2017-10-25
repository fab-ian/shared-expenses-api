class Payment < ApplicationRecord
  belongs_to :item
  validates :name, presence: true  
  validates :amount, presence:true, numericality: { only_integer: true }
end
