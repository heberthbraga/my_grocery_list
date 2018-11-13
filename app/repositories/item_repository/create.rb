class ItemRepository::Create < ApplicationService

  def initialize(item_request)
    @item_request = item_request
  end

  def call
    item = Item.new(@item_request)

    response = Handlers::Response.new(item)

    if item.save
      response.handle_success
    else
      Rails.logger.error "ItemRepository::Create = Error trying to save Item #{item.inspect}"
      response.handle_error category.errors.full_messages.join(" || ")
    end

    response
  end
end