password = Faker::Internet.password

FactoryBot.define do
  factory :user do
    name      { Faker::Name.name }
    nickname  { Faker::Pokemon.name.gsub(/[^0-9A-Za-z]/, '') }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }
  end
end
