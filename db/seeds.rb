Payment.destroy_all
ItemUser.destroy_all
Item.destroy_all
Credential.destroy_all
User.destroy_all

ActiveRecord::Base.transaction do
  user = RegisteredUser.create!(name: 'test')
  Credential.create!(email: 'test@test.pl', password: '1234', user_id: user.id)
end

puts '--------------'
puts 'Seeds created.'
puts '--------------'
