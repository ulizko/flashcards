FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@email.com" }
    password "qwerty123"
    password_confirmation "qwerty123"
  end
end
