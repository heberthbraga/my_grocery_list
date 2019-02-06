module Grocery::V1::Requests
  class GroceryItemRequest < ApplicationService
    
    def initialize(params)
      @params = params
    end

    def call
      {
        grocery_store_id: params[:grocery_store_id],
        item_id: params[:item_id],
        price: params[:price]
      }
    end

    private

    attr_reader :params
  end
end