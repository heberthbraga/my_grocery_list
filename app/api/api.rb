require 'grape-swagger'

class API < Grape::API  
  format :json

  rescue_from :all, :backtrace => true

  mount Grocery::V1::Base
end