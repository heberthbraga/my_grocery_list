module Grocery::V1::Requests
  class CategoryRequest < ApplicationService
    
    def initialize(params)
      @params = params
    end

    def call
      {
        name: params[:name],
        description: params[:description],
        parent_id: params[:parent_id]
      }
    end

    private

    attr_reader :params
  end
end