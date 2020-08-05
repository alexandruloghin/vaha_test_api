FactoryBot.define do
  factory :trainee do
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }
    name      { Faker::Name.name }
    expertise { "test expertise" }
  end
end