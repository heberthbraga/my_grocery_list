require 'rails_helper'

describe API::Authentication, type: :service do

  let(:username) { Faker::Name.first_name }
  let(:password) { Faker::Internet.password(8) }

  context 'when user does not exist' do
    it 'raises an exception' do
      expect {
        described_class.call(username, password)
      }.to raise_error(ExceptionService)
    end
  end

  context 'when password does not match' do
    let(:user) { create(:api_user) }

    it 'raises an exception' do
      expect {
        described_class.call(user.email, password)
      }.to raise_error(ExceptionService)
    end
  end

  context 'when the user has not api role' do
    let(:role) { create(:role, name: 'Client', position: 1) }
    let(:user) { create(:user, role: role, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password(8)) }

    it 'raises an exception' do
      expect {
        described_class.call(user.email, user.password)
      }.to raise_error(ExceptionService)
    end
  end

  context 'when user is authenticated successfully' do
    let(:user) { create(:api_user) }

    it 'returns the access token' do
      response = described_class.call(user.email, user.password)

      expect(response[:token]).not_to be_nil
    end
  end
end