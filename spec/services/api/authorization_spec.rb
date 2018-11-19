require 'rails_helper'

describe API::Authorization, type: :service do

  context 'When access token does not exist' do
    it 'raises an error' do
      expect {
        described_class.call(nil)
      }.to raise_error(ExceptionService)
    end
  end

  context 'When access token has expired' do
    let(:user) { create(:api_user) }
    let(:api_key) { create(:api_key, user: user) }

    before do
      allow_any_instance_of(ApiKey).to receive(:expired?).and_return(true)
    end

    it 'raises an error' do
      expect {
        described_class.call(api_key.access_token)
      }.to raise_error(ExceptionService)
    end
  end

  context 'When access token exists and hasn\'t expired yet' do
    let(:user) { create(:api_user) }
    let(:api_key) { create(:api_key, user: user) }

    it 'return the authenticated user' do
      current_user = described_class.call(api_key.access_token)

      expect(current_user).not_to be_nil
      expect(current_user.id).to eq user.id
    end
  end
end