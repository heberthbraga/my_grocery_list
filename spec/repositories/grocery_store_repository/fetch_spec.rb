require 'rails_helper'

describe GroceryStoreRepository::Fetch, type: :repository do

  context 'when a store exists' do
    let(:new_grocery_store) { create(:grocery_store) }

    it 'returns the store object' do
      existing_grocery_store = GroceryStoreRepository::Fetch.call new_grocery_store.id

      expect(existing_grocery_store).not_to be_nil
      expect(existing_grocery_store.name).not_to be_nil
      expect(existing_grocery_store.fantasy_name).not_to be_nil
      expect(existing_grocery_store.website).not_to be_nil
    end
  end

  context 'when a store not exists' do
  
    it 'returns nil' do
      existing_grocery_store = GroceryStoreRepository::Fetch.call 1001
      expect(existing_grocery_store).to be_nil
    end
  end

end