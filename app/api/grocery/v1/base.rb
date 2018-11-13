require "grape-swagger"

class Grocery::V1::Base < Grape::API
  prefix :api
  version 'v1', using: :header, vendor: 'grocery'

  helpers do
    def authenticate!
      authorization_header = request.headers['Authorization']
      error!({status: 'error', message: 'Authentication token not found.'}, 401) if authorization_header.nil?

      authorization_token = authorization_header.split(' ').last
      error!({status: 'error', message: 'Authentication token not found.'}, 401) if authorization_token.nil?

      begin
        authenticate = API::Authentication.new(params[:token])
        @current_user = authenticate.call
      rescue ServiceException => ex
        error!({status: 'error', message: ex.message}, 401)
      end
    end
  end

  namespace :auth do
    mount Authenticate
  end

  namespace :secured do
    before do
      authenticate!
    end
  end
end