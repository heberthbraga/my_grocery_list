class GroceryStore < ApplicationRecord

  has_many :grocery_items
  has_many :items, through: :grocery_items

  validates :name, presence: { message: 'Name cannot be empty' }
  validates :fantasy_name, presence: { message: 'Fantasy Name cannot be empty' }, uniqueness: { message: 'Store already exists' }
end
