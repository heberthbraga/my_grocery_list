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

      it 'returns the created category hash' do
        post "/api/v1/secured/categories?token=#{@token}", params: request

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        category_hash = JSON.parse(body)

        expect(category_hash).not_to be_nil
        expect(category_hash['id']).not_to be_nil
      end
    end
  end

  describe 'GET /api/v1/secured/categories' do
    
    context 'when fetching all existing and active categories' do
      before do
        create_list(:category, 10)
      end

      it 'returns an array of categories hash' do
        get "/api/v1/secured/categories?token=#{@token}"

        expect(response).not_to be_nil

        body = response.body

        expect(body).not_to be_nil

        categories_hash = JSON.parse(body)

        expect(categories_hash.size).to eq 10
      end
    end
  end

  describe 'PUT /api/v1/secured/categories/:id' do

    context 'when updating an existing category' do
      let(:category) { create(:category) }
      
      let(:request) {
        {
          name: 'Lorem'
        }
      }

      it 'returns the updated category hash' do
        put "/api/v1/secured/categories/#{category.id}?token=#{@token}", params: request

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        category_hash = JSON.parse(body)

        expect(category_hash).not_to be_nil
        expect(category_hash['id']).not_to be_nil
        expect(category_hash['name']).not_to be_nil
        expect(category_hash['name']).not_to eq category.name
      end
    end
  end

  describe 'GET /api/v1/secured/categories/:id' do
    context 'when fetching a Category' do
      let(:category) { create(:category) }

      before do
        create(:category, parent_id: category.id)
        category.reload
      end

      it 'returns an existing Item hash' do
        get "/api/v1/secured/categories/#{category.id}?token=#{@token}"

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        category_hash = JSON.parse(body)

        expect(category_hash).not_to be_nil
        expect(category_hash['id']).not_to be_nil
        expect(category_hash['id']).to eq category.id
        expect(category_hash['name']).not_to be_nil
        expect(category_hash['name']).to eq category.name
        expect(category_hash['subcategories'].size).to eq 1
      end
    end
  end

  describe 'DELETE /api/v1/secured/categories/:id' do
    let(:category) { create(:category) }

    context 'when destroying a category' do
       it 'should return the destroyed category' do
        delete "/api/v1/secured/categories/#{category.id}?token=#{@token}"

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        category_hash = JSON.parse(body)

        expect(category_hash).not_to be_nil
        expect(category_hash['id']).not_to be_nil
       end
    end
  end
end