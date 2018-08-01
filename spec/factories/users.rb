FactoryBot.define do
  factory :user do
    sequence(:username) {|n| "user#{n}"}
    sequence(:email) {|n| "person#{n}@example.com" }
    password 'password'
  end
end
