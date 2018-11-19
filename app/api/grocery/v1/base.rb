require "grape-swagger"

class Grocery::V1::Base < Grape::API
  prefix :api
  version 'v1', using: :path

  helpers do
    def authorize!
      begin
        @current_user = API::Authorization.call params[:token]
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

    mount GroceryStore
    mount Category
    mount Item
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