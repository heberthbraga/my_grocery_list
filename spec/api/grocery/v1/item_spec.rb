require 'rails_helper'

describe Grocery::V1::Item do
  include_context 'api_authentication'
  let(:category) { create(:category) }

  describe 'POST /api/v1/secured/items' do

    context 'when creating a new item' do
      let(:request) { 
        {
          name: Faker::Company.unique.name,
          category_ids: [category.id]
        }
       }

      it 'returns the created item' do
        post "/api/v1/secured/items?token=#{@token}", params: request

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        item = JSON.parse(body)

        expect(item).not_to be_nil
        expect(item['id']).not_to be_nil
        expect(item['name']).not_to be_nil
      end
    end
  end

  describe 'GET /api/v1/secured/items' do
    
    context 'when fetching all existing and active items' do
      before do
        create_list(:item, 10, category_ids: [category.id])
      end

      it 'returns an array of` items' do
        get "/api/v1/secured/items?token=#{@token}"

        expect(response).not_to be_nil

        body = response.body

        expect(body).not_to be_nil

        items = JSON.parse(body)

        expect(items.size).to eq 10
      end
    end
  end

  describe 'GET /api/v1/secured/items/:id' do
  
    context 'when fetching an Item' do
      let(:item) { create(:item, category_ids: [category.id]) }

      it 'returns an existing Item' do
        get "/api/v1/secured/items/#{item.id}?token=#{@token}"

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        item_hash = JSON.parse(body)

        expect(item_hash).not_to be_nil
        expect(item_hash['id']).not_to be_nil
        expect(item_hash['id']).to eq item.id
        expect(item_hash['name']).not_to be_nil
        expect(item_hash['name']).to eq item.name
      end
    end
  end
end