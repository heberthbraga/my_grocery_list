FactoryBot.define do
  factory :grocery_store do
    name { Faker::Company.name }
    fantasy_name { Faker::Name.unique.first_name }
    website { Faker::Internet.url }
  end
end