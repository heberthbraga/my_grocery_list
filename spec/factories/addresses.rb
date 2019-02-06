FactoryBot.define do
  factory :address do
    street  { Faker::Address.street_address }
    city    { Faker::Address.city }
    state   { Faker::Address.state_abbr }
    zip     { Faker::Address.zip_code }
    country { Faker::Address.country_code }

    trait :grocery_store do
      association :address, factory: :grocery_store
    end
  end
end