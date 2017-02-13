FactoryGirl.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.email(name.split.join('.')) }
    password              { Faker::Internet.password }
    password_confirmation { password }
  end
end
