FactoryBot.define do
  factory :member do
    email                 { "test@test" }
    nickname              { "テストユーザ" }
    password              { "testtest" }
    password_confirmation { "testtest" }
  end
end
