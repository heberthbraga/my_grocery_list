FactoryBot.define do
  factory :item do
    name        { Faker::Lorem.unique.word.upcase }
    picture     { nil }
  end
end