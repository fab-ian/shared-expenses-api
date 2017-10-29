FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
  end

  factory :registered_user, class: 'RegisteredUser' do
    name { Faker::Name.name }
    type { 'RegisteredUser' }
  end

  factory :virtual_user, class: 'VirtualUser' do
    name { Faker::Name.name }
    type { 'VirtualUser' }
  end
end
