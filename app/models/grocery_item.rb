class GroceryItem < ApplicationRecord

  belongs_to :grocery_store
  belongs_to :item

  validates :price, presence: { message: 'Price cannot be blank' }
  validates :item, presence: true
  validates :grocery_store, presence: true
end
