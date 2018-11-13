FactoryBot.define do
  factory :user do
    factory :api_user, class: User do
      role        { association(:api_role) }
      first_name  { Faker::Name.first_name }
      last_name   { Faker::Name.last_name }
      email       { Faker::Internet.email }
      password    { Faker::Internet.password(8) }
      active      { true }
    end
  end
end