module Grocery::V1::Requests
  class AddressRequest < ApplicationService

    def initialize(params)
      @params = params
    end

    def call
      {
        street: params[:street],
        city: params[:city],
        state: params[:state],
        zip: params[:zip]
      }
    end

    private

    attr_reader :params
  end
end