FactoryBot.define do
  factory :item_category do
    item     { association(:item) }
    category { association(:category) }
  end
end