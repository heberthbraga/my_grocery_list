FactoryBot.define do

  factory :role do
    factory :api_role, class: Role do
      name { 'API' }
      position { 0 }
    end
  end
end