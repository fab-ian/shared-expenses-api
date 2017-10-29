FactoryGirl.define do
  factory :credential do
    email 'test@test.pl'
    password '123456'
    user
  end
end
