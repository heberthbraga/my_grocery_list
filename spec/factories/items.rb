FactoryBot.define do
  factory :item do
    name         { Faker::Lorem.unique.word.upcase }
    quantity     { 1 }
    picture      { nil }
  end
end