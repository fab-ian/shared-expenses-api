FactoryGirl.define do
  factory :item do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    user
  end
end
