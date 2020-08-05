FactoryBot.define do
  factory :exercise do
    sequence(:name) {|n| "Test exercise #{n}" }
    duration { rand(1800..7200) }
  end
end