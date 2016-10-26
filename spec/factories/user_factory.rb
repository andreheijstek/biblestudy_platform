FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password "password"
    username "username"

    trait :admin do
      admin true
    end
  end
end
