require 'rails_helper'

describe Grocery::V1::GroceryStore do
  include_context 'api_authentication'

  describe 'POST /api/v1/secured/stores' do

    context 'when creating a new grocery store' do
      let(:request) { 
        {
          name: Faker::Company.name,
          fantasy_name: Faker::Name.unique.first_name,
          website: Faker::Internet.url
        }
       }

      it 'returns the created store' do
        post "/api/v1/secured/stores?token=#{@token}", params: request

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        grocery_store = JSON.parse(body)

        expect(grocery_store).not_to be_nil
        expect(grocery_store['id']).not_to be_nil
      end
    end
  end

  describe 'GET /api/v1/secured/stores' do
    
    context 'when fetching all existing and active stores' do
      before do
        create_list(:grocery_store, 5)
      end

      it 'returns an array of stores' do
        get "/api/v1/secured/stores?token=#{@token}"

        expect(response).not_to be_nil

        body = response.body

        expect(body).not_to be_nil

        grocery_stores = JSON.parse(body)

        expect(grocery_stores.size).to eq 5
      end
    end
  end

  describe 'GET /api/v1/secured/stores/:id' do
  
    context 'when fetching a store' do
      let(:store) { create(:grocery_store) }

      it 'returns an existing store' do
        get "/api/v1/secured/stores/#{store.id}?token=#{@token}"

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        grocery_store = JSON.parse(body)

        expect(grocery_store).not_to be_nil
        expect(grocery_store['id']).not_to be_nil
        expect(grocery_store['id']).to eq store.id
      end
    end
  end

end