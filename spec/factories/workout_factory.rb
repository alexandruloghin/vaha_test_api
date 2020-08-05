FactoryBot.define do
  factory :workout do
    sequence(:name) {|n| "Test workout #{n}" }
  end
end