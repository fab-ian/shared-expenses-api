class Payment < ApplicationRecord
  belongs_to :item
  validates :name, :description, presence: true  
end
