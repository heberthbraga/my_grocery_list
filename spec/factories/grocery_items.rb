FactoryBot.define do
  factory :grocery_item do
    grocery_store { association(:grocery_store) }
    price         { Faker::Number.decimal(2) }
  end
end