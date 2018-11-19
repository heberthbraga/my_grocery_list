require 'rails_helper'

describe Grocery::V1::Category do
  include_context 'api_authentication'

  describe 'POST /api/v1/secured/categories' do

    context 'when creating a new category' do
      let(:request) { 
        {
          name: Faker::Company.unique.name,
          description: Faker::Lorem.sentence
        }
       }

      it 'returns the created category' do
        post "/api/v1/secured/categories?token=#{@token}", params: request

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        category = JSON.parse(body)

        expect(category).not_to be_nil
        expect(category['id']).not_to be_nil
      end
    end
  end

  describe 'GET /api/v1/secured/categories' do
    
    context 'when fetching all existing and active categories' do
      before do
        create_list(:category, 10)
      end

      it 'returns an array of categories' do
        get "/api/v1/secured/categories?token=#{@token}"

        expect(response).not_to be_nil

        body = response.body

        expect(body).not_to be_nil

        categories = JSON.parse(body)

        expect(categories.size).to eq 10
      end
    end
  end
end