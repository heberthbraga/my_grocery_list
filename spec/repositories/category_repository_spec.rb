require 'rails_helper'

describe CategoryRepository, type: :repository do

  subject(:category_repository) { described_class.new}

  describe '#create' do
    context 'when creating a Category with success' do
      let(:request) {
        {
          name: Faker::Company.unique.name,
          description: Faker::Lorem.sentence
        }
      }
  
      it 'returns the created category with id' do
        category = category_repository.create request
  
        expect(category).not_to be_nil
        expect(category.persisted?).to eq true
        expect(category.id).not_to be_nil
        expect(category.name).not_to be_nil
        expect(category.description).not_to be_nil
      end
    end
  
    context 'when creating a category fails' do
      let(:request) {
        {
          name: nil,
          description: Faker::Lorem.sentence
        }
      }

      it 'returns a not persisted category' do
        expect {
          category_repository.create request
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#fetch' do
    context 'when a category exists' do
      let(:new_category) { create(:category) }
  
      it 'returns the store object' do
        existing_category = category_repository.fetch new_category.id
  
        expect(existing_category).not_to be_nil
        expect(existing_category.name).not_to be_nil
        expect(existing_category.description).not_to be_nil
      end
    end
  
    context 'when a category does not exist' do
      it 'returns nil' do
        existing_grocery_store = category_repository.fetch 1001
        expect(existing_grocery_store).to be_nil
      end
    end
  end
end