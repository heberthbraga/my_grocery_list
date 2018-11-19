shared_context 'api_authentication' do
  before do
    api_user = create(:api_user)
    
    post '/api/v1/auth/login', params: {username: api_user.email, password: api_user.password, format: :json}
    
    @token = JSON.parse(response.body)['token']
  end
end