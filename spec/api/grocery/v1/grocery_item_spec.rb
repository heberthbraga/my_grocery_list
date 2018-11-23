require 'rails_helper'

describe Grocery::V1::GroceryItem do
  include_context 'api_authentication'

  let(:category) { create(:category) }
  let(:item) { create(:item, category_ids: [category.id]) }
  let(:grocery_store) { create(:grocery_store) }

  describe 'POST /api/v1/secured/grocery_items' do
    context 'when creating a new association' do
      let(:request) { 
        {
          item_id: item.id,
          grocery_store_id: grocery_store.id,
          price: 20.99
        }
       }

       it 'returns the created grocery item hash' do
        post "/api/v1/secured/grocery_items?token=#{@token}", params: request

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        grocery_item_hash = JSON.parse(body)

        expect(grocery_item_hash).not_to be_nil
        expect(grocery_item_hash['id']).not_to be_nil
        expect(grocery_item_hash['price']).not_to be_nil
        expect(grocery_item_hash['grocery_store']).not_to be_nil
        expect(grocery_item_hash['grocery_store']['id']).to eq grocery_store.id
       end
    end
  end

  describe 'DELETE /api/v1/secured/grocery_items/:id' do
    let(:grocery_item) { create(:grocery_item, item: item) }

    context 'when destroying an association' do
       it 'returns the destroyed object' do
        delete "/api/v1/secured/grocery_items/#{grocery_item.id}?token=#{@token}"

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        grocery_item_hash = JSON.parse(body)

        expect(grocery_item_hash).not_to be_nil
        expect(grocery_item_hash['id']).not_to be_nil
        expect(grocery_item_hash['price']).not_to be_nil
       end
    end
  end
end