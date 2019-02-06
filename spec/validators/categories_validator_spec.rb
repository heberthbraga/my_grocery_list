require 'rails_helper'

describe CategoriesValidator, type: :validator do

  context 'when category_ids is nil' do
    subject(:item) { build(:item) }

    it 'returns validation error' do
      item.valid?

      errors = item.errors.messages
      expect(errors.size).to be > 0
      expect(errors[:categories]).to include 'Select at least one category.'
    end
  end

  context 'when category_ids is empty' do
    subject(:item) { build(:item, category_ids: []) }

    it 'returns validation error' do
      item.valid?

      errors = item.errors.messages
      expect(errors.size).to be > 0
      expect(errors[:categories]).to include 'Select at least one category.'
    end
  end
end