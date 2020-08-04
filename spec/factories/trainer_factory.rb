FactoryBot.define do
  factory :trainer do
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }
    name      { Faker::Name.name }
    expertise { "body building" }
  end
end