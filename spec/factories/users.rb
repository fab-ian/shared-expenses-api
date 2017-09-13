FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email 'test@test.pl'
    password '123456'
  end
end
