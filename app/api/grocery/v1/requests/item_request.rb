module Grocery::V1::Requests
  class ItemRequest < ApplicationService
    
    def initialize(params)
      @params = params
    end

    def call
      {
        category_ids: params[:category_ids].present? ? params[:category_ids].split(',').map(&:to_i) : nil,
        name: params[:name],
        quantity: params[:quantity],
        picture: params[:picture]
      }
    end

    private

    attr_reader :params
  end
end