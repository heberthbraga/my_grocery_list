require 'rails_helper'

describe ItemRepository, type: :repository do

  subject(:item_repository) { described_class.new }

  describe '#create' do
    context 'when creating an Item with success' do
      let(:category) { create(:category) }
      
      let(:request) {
        {
          name: Faker::Lorem.unique.word.upcase,
          quantity: 1,
          category_ids: [category.id]
        }
      }
  
      it 'returns the created item with id' do
        item = item_repository.create request
  
        expect(item).not_to be_nil
        expect(item.persisted?).to eq true
        expect(item.id).not_to be_nil
        expect(item.name).not_to be_nil
        expect(item.categories.size).to eq 1
      end
    end
  
    context 'when creating an Item fails' do
      let(:request) {
        {
          name: nil,
        }
      }
  
      it 'returns a not persisted item' do
        expect {
          item_repository.create request
        }.to raise_error(ExceptionService)
      end
    end
  end

  describe '#fetch' do
    context 'when an Item exists' do
      let(:category) { create(:category) }
      let(:new_item) { create(:item, category_ids: [category.id]) }
  
      it 'returns the Item object' do
        existing_item = item_repository.fetch new_item.id
  
        expect(existing_item).not_to be_nil
        expect(existing_item.name).not_to be_nil
      end
    end
  
    context 'when an Item not exists' do
    
      it 'returns nil' do
        existing_item = item_repository.fetch 1001
        expect(existing_item).to be_nil
      end
    end
  end

  describe '#update' do
    context 'when updating an Item with success' do
      let(:category_one) { create(:category) }
      let(:category_two) { create(:category) }

      let(:item) { create(:item, category_ids: [category_one.id]) }
      
      let(:request) {
        {
          name: 'Lorem',
          category_ids: [category_two.id]
        }
      }
  
      it 'returns the updated store' do
        existing_item = item_repository.update item.id, request
  
        expect(existing_item).not_to be_nil
        expect(existing_item.persisted?).to eq true
        expect(existing_item.name).not_to be_nil
        expect(existing_item.name).not_to eq item.name
      end
    end
  end

  describe '#fetch_all_by_price' do
    let(:categories) { create_list(:category, 2) }
    let(:grocery_stores) { create_list(:grocery_store, 2) }

    let(:item_one) { create(:item, category_ids: categories.collect{|c|c.id}) }
    let(:item_two) { create(:item, category_ids: categories.collect{|c|c.id}) }

    before do
      create(:grocery_item, item: item_one, grocery_store: grocery_stores.first, price: 22.00)
      create(:grocery_item, item: item_one, grocery_store: grocery_stores.last, price: 43.00)

      create(:grocery_item, item: item_two, grocery_store: grocery_stores.first, price: 19.00)
      create(:grocery_item, item: item_two, grocery_store: grocery_stores.last, price: 45.00)
    end

    context 'when fetching items by lower prices' do
      it 'returns a list of ordered items' do
        items = item_repository.fetch_all_by :price

        expect(items.size).to be > 0

        first_item = items.first
        second_item = items.last

        expect(first_item).not_to be_nil
        expect(second_item).not_to be_nil
        expect(first_item.id).to eq item_two.id
        expect(second_item.id).to eq item_one.id
      end
    end

    context 'when fetching items by higher prices' do
      it 'returns a list of ordered items' do
        items = item_repository.fetch_all_by :price, :asc

        expect(items.size).to be > 0

        first_item = items.first
        second_item = items.last

        expect(first_item).not_to be_nil
        expect(second_item).not_to be_nil
        expect(first_item.id).to eq item_two.id
        expect(second_item.id).to eq item_one.id
      end
    end
  end

  describe '#fetch_all_not_matched_store' do
    let(:categories) { create_list(:category, 2) }
    let(:grocery_stores) { create_list(:grocery_store, 2) }

    before do
      @item_one = create(:item, category_ids: categories.collect{|c|c.id})
      @item_two = create(:item, category_ids: categories.collect{|c|c.id})

      @grocery_stores_first = grocery_stores.first

      create(:grocery_item, item: @item_one, grocery_store: @grocery_stores_first, price: 22.00)
    end

    context 'when fetching items that not matched store' do
      it 'returns a list of ordered items' do
        items = item_repository.fetch_all_not_matched_store @grocery_stores_first.id

        expect(items.size).to eq 1

        first_item = items.first
        expect(first_item).not_to be_nil
        expect(first_item.id).to eq @item_two.id
      end
    end
  end

  describe '#search' do
    let(:categories) { create_list(:category, 2) }
    let(:grocery_stores) { create_list(:grocery_store, 2) }

    before do
      create(:item, name: 'Lorem ipsum', category_ids: categories.collect{|c|c.id})
      create(:item, name: 'Lorem Test', category_ids: categories.collect{|c|c.id})
    end

    context 'when searching for items based on a keyword' do
      it 'should return a list of ordered items' do
        items = item_repository.search 'Lore'

        expect(items.size).to eq 2
      end
    end
  end

end