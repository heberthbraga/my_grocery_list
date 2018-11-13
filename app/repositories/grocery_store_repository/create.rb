class GroceryStoreRepository::Create < ApplicationService

  def initialize(store_request)
    @store_request = store_request
  end

  def call
    grocery_store = GroceryStore.new(@store_request)

    response = Handlers::Response.new(grocery_store)

    if grocery_store.save
      response.handle_success
    else
      Rails.logger.error "GroceryStoreService::Create = Error trying to save Store #{grocery_store.inspect}"
      response.handle_error grocery_store.errors.full_messages.join(" || ")
    end

    response
  end
end