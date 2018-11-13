class GroceryStoreRepository::Fetch < ApplicationService

  def initialize(grocery_store_id)
    @grocery_store_id = grocery_store_id
  end

  def call
    Rails.logger.debug "GroceryStoreRepository::Fetch = Fetching Store #{@grocery_store_id}"
    begin
      GroceryStore.find(@grocery_store_id)
    rescue => ex
      response = Handlers::Response.new
      response.handle_error [ex.message]

      return nil
    end
  end
end