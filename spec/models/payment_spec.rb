require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { should belong_to(:item) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of (:amount) }
  it { should validate_numericality_of(:amount) }
end
