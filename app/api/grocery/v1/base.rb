require "grape-swagger"

class Grocery::V1::Base < Grape::API
  prefix :api
  version 'v1', using: :path

  helpers do
    def authorize!
      authorization_header = request.headers['Authorization']
      error!({status: 'error', message: 'Authentication token not found.'}, 401) if authorization_header.nil?

      authorization_token = authorization_header.split(' ').last
      error!({status: 'error', message: 'Authentication token not found.'}, 401) if authorization_token.nil?

      begin
        authorize = API::Authorization.new(params[:token])
        @current_user = authorize.call
      rescue ExceptionService => ex
        error!({status: 'error', message: ex.message}, 401)
      end
    end
  end

  namespace :auth do
    mount Authenticate
  end

  namespace :secured do
    before do
      authorize!
    end
  end

  add_swagger_documentation( 
    api_version: 'v1',
   
    info: {
      title: "My Grocery List",
      description: "List and manipulate grocery items from different stores in order to compare prices."
    },
    hide_documentation_path: true        
  )
end