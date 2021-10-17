FactoryBot.define do
  factory :list do
    name { Faker::Lorem.characters(number:10) }
  end
end