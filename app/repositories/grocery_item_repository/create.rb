class GroceryItemRepository::Create < ApplicationService

  def initialize(grocery_item_request)
    @grocery_item_request = grocery_item_request
  end

  def call
    grocery_item = GroceryItem.new(@grocery_item_request)

    response = Handlers::Response.new(grocery_item)

    if grocery_item.save
      response.handle_success
    else
      Rails.logger.error "CategoryRepository::Create = Error trying to save Grocery Item #{grocery_item.inspect}"
      response.handle_error grocery_item.errors.full_messages.join(" || ")
    end

    response
  end
end