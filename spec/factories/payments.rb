FactoryGirl.define do
  factory :payment do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    item
  end
end
