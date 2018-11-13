class ItemRepository::Fetch < ApplicationService

  def initialize(item_id)
    @item_id = item_id
  end
  
  def call
    Rails.logger.debug "ItemRepository::Fetch = Fetching Item #{@item_id}"
    begin
      Item.find(@item_id)
    rescue => ex
      response = Handlers::Response.new
      response.handle_error [ex.message]

      return nil
    end
  end
end