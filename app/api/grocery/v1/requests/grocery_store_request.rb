module Grocery::V1::Requests
  class GroceryStoreRequest < ApplicationService
    
    def initialize(params)
      @params = params
    end

    def call
      grocery_params = {
        name: params[:name],
        fantasy_name: params[:fantasy_name],
        website: params[:website],
      }

      grocery_params.merge!({address_attributes: AddressRequest.call(params[:address])}) if params[:address].present?

      grocery_params
    end

    private

    attr_reader :params
  end
end