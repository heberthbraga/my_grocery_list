require 'rails_helper'

describe API::Authentication, type: :service do

  let(:username) { Faker::Name.first_name }
  let(:password) { Faker::Internet.password(8) }

  context 'when user does not exist' do
    subject(:authenticate) { described_class.new(username, password) }

    it 'raises an exception' do
      expect {
        authenticate.call
      }.to raise_error(AuthenticationError)
    end
  end

  context 'when password does not match' do
    let(:user) { create(:api_user) }

    subject(:authenticate) { described_class.new(user.email, password) }

    it 'raises an exception' do
      expect {
        authenticate.call
      }.to raise_error(AuthenticationError)
    end
  end

  context 'when the user has not api role' do
    let(:role) { create(:role, name: 'Client', position: 1) }
    let(:user) { create(:user, role: role, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password(8)) }
    
    subject(:authenticate) { described_class.new(user.email, user.password) }

    it 'raises an exception' do
      expect {
        authenticate.call
      }.to raise_error(AuthenticationError)
    end
  end

  context 'when user is authenticated successfully' do
    let(:user) { create(:api_user) }

    subject(:authenticate) { described_class.new(user.email, user.password) }

    it 'returns the access token' do
      response = authenticate.call

      expect(response[:token]).not_to be_nil
    end
  end
end