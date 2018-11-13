class ItemRepository::FetchAll < ApplicationService

  def call
    Item.active
  end
end