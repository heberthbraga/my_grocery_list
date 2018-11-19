module Grocery::V1::Requests
  class GroceryStoreRequest < ApplicationService
    
    def initialize(params)
      @params = params
    end

    def call
      {
        name: params[:name],
        fantasy_name: params[:fantasy_name],
        website: params[:website]
      }
    end

    private

    attr_reader :params
  end
end