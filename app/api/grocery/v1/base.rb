require "grape-swagger"

class Grocery::V1::Base < Grape::API
  prefix :api
  version 'v1', using: :path

  helpers Grocery::V1::Helpers::AuthenticationHelpers

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