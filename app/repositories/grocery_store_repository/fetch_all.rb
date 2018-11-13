class GroceryStoreRepository::FetchAll < ApplicationService

  def call
    GroceryStore.active
  end
end