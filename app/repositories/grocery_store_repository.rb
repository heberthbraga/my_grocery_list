class GroceryStoreRepository
  include Fetchable
  fetchable :grocery_store

  def initialize
  end
  
  def create(grocery_item_request)
    Rails.logger.debug "GroceryStoreRepository#create = Creating Store #{grocery_item_request}"

    grocery_store = GroceryStore.new(grocery_item_request)

    grocery_store.save!

    grocery_store
  end

  def fetch_all
    active_stores = GroceryStore.active

    Rails.logger.debug "GroceryStoreRepository#fetch_all = Fetching #{active_stores.size} Store(s)"

    active_stores
  end

private

  attr_reader :grocery_item_request
end