FactoryBot.define do
  factory :category do
    name        { Faker::Company.unique.name }
    description { Faker::Lorem.sentence }
  end
end