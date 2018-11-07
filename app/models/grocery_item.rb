class GroceryItem < ApplicationRecord

  belongs_to :greocery_store
  belongs_to :item

  validates :price, presence: { message: 'Price cannot be blank' }
end
