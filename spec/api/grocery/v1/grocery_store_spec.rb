require 'rails_helper'

describe Grocery::V1::GroceryStore do
  include_context 'api_authentication'

  describe 'POST /api/v1/secured/stores' do

    context 'when creating a new grocery store' do
      let(:request) { 
        {
          name: Faker::Company.name,
          fantasy_name: Faker::Name.unique.first_name,
          website: Faker::Internet.url,
          address: {
            street: Faker::Address.street_address,
            city: Faker::Address.city,
            state: Faker::Address.state_abbr,
            zip: Faker::Address.zip_code
          } 
        }
       }

      it 'returns the created store hash' do
        post "/api/v1/secured/stores?token=#{@token}", params: request

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        grocery_store_hash = JSON.parse(body)

        expect(grocery_store_hash).not_to be_nil
        expect(grocery_store_hash['id']).not_to be_nil
      end
    end
  end

  describe 'GET /api/v1/secured/stores' do
    
    context 'when fetching all existing and active stores' do
      before do
        create_list(:grocery_store, 5)
      end

      it 'returns an array of stores hash' do
        get "/api/v1/secured/stores?token=#{@token}"

        expect(response).not_to be_nil

        body = response.body

        expect(body).not_to be_nil

        grocery_stores_hash = JSON.parse(body)

        expect(grocery_stores_hash.size).to eq 5
      end
    end
  end

  describe 'GET /api/v1/secured/stores/:id' do
  
    context 'when fetching a store' do
      let(:store) { create(:grocery_store) }

      it 'returns an existing store hash' do
        get "/api/v1/secured/stores/#{store.id}?token=#{@token}"

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        grocery_store_hash = JSON.parse(body)

        expect(grocery_store_hash).not_to be_nil
        expect(grocery_store_hash['id']).not_to be_nil
        expect(grocery_store_hash['id']).to eq store.id
      end
    end
  end

  describe 'PUT /api/v1/secured/stores' do

    context 'when updating an existing grocery store' do
      let(:grocery_store) { create(:grocery_store) }
      
      let(:request) {
        {
          name: 'Lorem',
          fantasy_name: 'lorem'
        }
      }

      it 'returns the updated grocery store hash' do
        put "/api/v1/secured/stores/#{grocery_store.id}?token=#{@token}", params: request

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        grocery_store_hash = JSON.parse(body)

        expect(grocery_store_hash).not_to be_nil
        expect(grocery_store_hash['id']).not_to be_nil
        expect(grocery_store_hash['name']).not_to be_nil
        expect(grocery_store_hash['name']).not_to eq grocery_store.name
        expect(grocery_store_hash['fantasy_name']).not_to be_nil
        expect(grocery_store_hash['fantasy_name']).not_to eq grocery_store.fantasy_name
      end
    end
  end

  describe 'DELETE /api/v1/secured/stores/:id' do
    let(:grocery_store) { create(:grocery_store) }

    context 'when destroying a store' do
       it 'should return the destroyed store' do
        delete "/api/v1/secured/stores/#{grocery_store.id}?token=#{@token}"

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        grocery_store_hash = JSON.parse(body)

        expect(grocery_store_hash).not_to be_nil
        expect(grocery_store_hash['id']).not_to be_nil
       end
    end
  end

end