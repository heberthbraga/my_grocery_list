require 'rails_helper'

describe ItemRepository, type: :repository do

  subject(:item_repository) { described_class.new }

  describe '#create' do
    context 'when creating an Item with success' do
      let(:category) { create(:category) }
      
      let(:request) {
        {
          name: Faker::Lorem.unique.word.upcase,
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
        }.to raise_error(ActiveRecord::RecordInvalid)
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

end