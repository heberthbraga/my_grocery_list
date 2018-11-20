require 'rails_helper'

describe GroceryItemRepository, type: :repository do

  subject(:grocery_item_repository) { described_class.new }

  describe '#create' do
    context 'when associating an item to a grocery store' do
      let(:store) { create(:grocery_store) }
      let(:category) { create(:category) }
      let(:item)  { create(:item, category_ids: [category.id]) }

      let(:request) {
        {
          item_id: item.id,
          grocery_store_id: store.id,
          price: Faker::Number.decimal(2)
        }
      }

      it 'returns the created grocery item association' do
        grocery_item = grocery_item_repository.create request

        expect(grocery_item).not_to be_nil
        expect(grocery_item.persisted?).to eq true
        expect(grocery_item.id).not_to be_nil
        expect(grocery_item.item).not_to be_nil
        expect(grocery_item.item.id).not_to be_nil
        expect(grocery_item.grocery_store).not_to be_nil
        expect(grocery_item.grocery_store.id).not_to be_nil
        expect(grocery_item.price).not_to be_nil
      end
    end

    context 'when creating a store fails' do
      let(:store) { create(:grocery_store) }

      let(:request) {
        {
          item_id: nil,
          grocery_store_id: store.id,
          price: nil
        }
      }
  
      it 'returns a not persisted store' do
        expect {
          grocery_item_repository.create request
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#destroy' do
    context 'when removing a grocery item association' do
      let(:category) { create(:category) }
      let(:item)  { create(:item, category_ids: [category.id]) }
      let(:grocery_item) { create(:grocery_item, item: item) }

      it 'returns the destroyed object' do
        result = grocery_item_repository.destroy grocery_item.id
        
        expect(result).not_to be_nil

        grocery_items = GroceryItem.all
        expect(grocery_items.size).to eq 0
      end
    end
  end
end