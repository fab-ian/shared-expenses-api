require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:payments) }
  it { should validate_presence_of(:name) }
end
