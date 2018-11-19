class ItemRepository
  include Fetchable
  fetchable :item

  def initialize
  end

  def create(item_request)
    Rails.logger.debug "ItemRepository#create = Creating Item #{item_request.inspect}"

    item = Item.new(item_request)

    item.save!

    item
  end

  def fetch_all
    active_items = Item.active

    Rails.logger.debug "ItemRepository#fetch_all = Fetching #{active_items.size} Item(s)"

    active_items
  end

private

  attr_reader :item_request
end