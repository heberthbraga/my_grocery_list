require 'rails_helper'

describe Grocery::V1::Authenticate do

  describe 'POST /api/v1/auth/login' do
  
    context 'when user is successfully authenticated' do
      let(:user) { create(:api_user) }

      it 'returns the access token ' do
        post '/api/v1/auth/login', params: {username: user.email, password: user.password}

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        response_hash = JSON.parse(body)

        expect(response_hash["token"]).not_to be_nil
      end
    end

    context 'when fails to authenticate user' do
      let(:user) { create(:api_user) }

      it 'returns an error response' do
        post '/api/v1/auth/login', params: {username: user.email, password: 'test'}

        expect(response).not_to be_nil
        body = response.body
        expect(body).not_to be_nil

        response_hash = JSON.parse(body)

        expect(response_hash["status"]).not_to be_nil
        expect(response_hash["status"]).to eq 'error'
        expect(response_hash["message"]).not_to be_nil
        expect(response_hash["message"]).to include 'Failed to authenticate user'
      end
    end
  end

end