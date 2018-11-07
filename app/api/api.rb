require 'grape-swagger'

class API < Grape::API
  version 'v1', using: :header, vendor: 'grocery'
  
  format :json

  rescue_from :all, :backtrace => true

  mount Grocery::Base
  
end