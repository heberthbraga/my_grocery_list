require 'rails_helper'

describe Item, type: :model do

  describe '#lowest_store_price' do
    let(:categories) { create_list(:category, 2) }
    let(:grocery_stores) { create_list(:grocery_store, 2) }

    let(:item) { create(:item, category_ids: categories.collect{|c|c.id}) }

    before do
      @grocery_item_one = create(:grocery_item, item: item, grocery_store: grocery_stores.first, price: 22.00)
      @grocery_item_two = create(:grocery_item, item: item, grocery_store: grocery_stores.last, price: 43.00)
    end

    context 'when fetching an item\'s lowest price' do
      it 'returns the lowest price' do
        lowest_store_price = item.lowest_store_price

        expect(lowest_store_price).not_to be_nil
        p lowest_store_price
        expect(lowest_store_price[:price]).to eq @grocery_item_one.price
        expect(lowest_store_price[:price]).not_to eq @grocery_item_two.price
      end
    end
  end
end