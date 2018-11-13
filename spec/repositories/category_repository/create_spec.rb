require 'rails_helper'

describe CategoryRepository::Create, type: :repository do

  context 'when creating a category with success' do
    let(:request) {
      {
        name: Faker::Company.name,
        fantasy_name: Faker::Name.unique.first_name,
        website: Faker::Internet.url
      }
    }
  end

end