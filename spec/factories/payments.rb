FactoryGirl.define do
  factory :payment do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    amount { 100 }
    item
    user
  end
end
