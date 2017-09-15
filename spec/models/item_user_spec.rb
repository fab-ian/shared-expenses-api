require 'rails_helper'

RSpec.describe ItemUser, type: :model do
  it { should belong_to(:item) }
  it { should belong_to(:user) }
end
