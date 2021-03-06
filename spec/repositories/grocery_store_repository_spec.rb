require 'rails_helper'

describe GroceryStoreRepository, type: :repository do

  subject(:grocery_store_repository) { described_class.new }

  describe '#create' do
    context 'when creating a store with success' do
      let(:request) {
        {
          name: Faker::Company.name,
          fantasy_name: Faker::Name.unique.first_name,
          website: Faker::Internet.url,
          address_attributes: {
            street: Faker::Address.street_address,
            city: Faker::Address.city,
            state: Faker::Address.state_abbr,
            zip: Faker::Address.zip_code
          } 
        }
      }
  
      it 'returns the created store with id' do
        grocery_store = grocery_store_repository.create request
  
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
        expect {
          grocery_store_repository.create request
        }.to raise_error(ExceptionService)
      end
    end
  end

  describe '#fetch' do
    context 'when a store exists' do
      let(:new_grocery_store) { create(:grocery_store) }
  
      it 'returns the store object' do
        existing_grocery_store = grocery_store_repository.fetch new_grocery_store.id
  
        expect(existing_grocery_store).not_to be_nil
        expect(existing_grocery_store.name).not_to be_nil
        expect(existing_grocery_store.fantasy_name).not_to be_nil
        expect(existing_grocery_store.website).not_to be_nil
      end
    end
  
    context 'when a store not exists' do
    
      it 'returns nil' do
        existing_grocery_store = grocery_store_repository.fetch 1001
        expect(existing_grocery_store).to be_nil
      end
    end
  end

  describe '#update' do
    context 'when updating a Store with success' do
      let(:grocery_store) { create(:grocery_store) }
      
      let(:request) {
        {
          name: 'Lorem',
          fantasy_name: 'lorem'
        }
      }
  
      it 'returns the updated store' do
        existing_store = grocery_store_repository.update grocery_store.id, request
  
        expect(existing_store).not_to be_nil
        expect(existing_store.persisted?).to eq true
        expect(existing_store.name).not_to be_nil
        expect(existing_store.name).not_to eq grocery_store.name
      end
    end
  end
end