FactoryBot.define do
  factory :list do
    member_id { 1 }
    name { Faker::Lorem.characters(number: 10) }
  end
end
