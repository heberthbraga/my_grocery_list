require "grape-swagger"

module Grocery
  class Base < Grape::API
    prefix :api
    version 'v1', using: :header, vendor: 'grocery'
  end
end