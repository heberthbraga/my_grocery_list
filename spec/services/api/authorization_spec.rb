require 'rails_helper'

describe API::Authorization, type: :service do

  context 'When access token does not exist' do
    subject(:authorize) { described_class.new(nil) }

    it 'raises an error' do
      expect {
        authorize.call
      }.to raise_error(UnauthorizedError)
    end
  end

  context 'When access token has expired' do
    let(:user) { create(:api_user) }
    let(:api_key) { create(:api_key, user: user) }

    subject(:authorize) { described_class.new(api_key.access_token) }

    before do
      allow_any_instance_of(ApiKey).to receive(:expired?).and_return(true)
    end

    it 'raises an error' do
      expect {
        authorize.call
      }.to raise_error(UnauthorizedError)
    end
  end

  context 'When access token exists and hasn\'t expired yet' do
    let(:user) { create(:api_user) }
    let(:api_key) { create(:api_key, user: user) }

    subject(:authorize) { described_class.new(api_key.access_token) }

    it 'return the authenticated user' do
      current_user = authorize.call

      expect(current_user).not_to be_nil
      expect(current_user.id).to eq user.id
    end
  end
end