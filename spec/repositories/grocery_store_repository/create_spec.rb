require 'rails_helper'

describe GroceryStoreRepository::Create, type: :repository do

  context 'when creating a store with success' do
    let(:request) {
      {
        name: Faker::Company.name,
        fantasy_name: Faker::Name.unique.first_name,
        website: Faker::Internet.url
      }
    }

    it 'returns the created store with id' do
      response = GroceryStoreRepository::Create.call request

      expect(response).not_to be_nil
      expect(response.success).to eq true

      grocery_store = response.entity

      expect(grocery_store).not_to be_nil
      expect(grocery_store.persisted?).to eq true
      expect(grocery_store.id).not_to be_nil
      expect(grocery_store.name).not_to be_nil
      expect(grocery_store.fantasy_name).not_to be_nil
      expect(grocery_store.website).not_to be_nil
    end
  end

  context 'when creating a store fails' do
    let(:request) {
      {
        fantasy_name: Faker::Name.unique.first_name,
        website: Faker::Internet.url
      }
    }

    it 'returns a not persisted store' do
      response = GroceryStoreRepository::Create.call request

      expect(response).not_to be_nil
      expect(response.success).to eq false

      grocery_store = response.entity

      expect(grocery_store).not_to be_nil
      expect(grocery_store.persisted?).to eq false
      expect(grocery_store.id).to be_nil
    end
  end
end