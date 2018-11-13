class GroceryStore < ApplicationRecord
  include Activable

  has_many :grocery_items
  has_many :items, through: :grocery_items

  default_scope { order(:created_at) }

  validates :name, presence: { message: 'Name cannot be empty' }
  validates :fantasy_name, presence: { message: 'Fantasy Name cannot be empty' }, uniqueness: { message: 'Store already exists' }  

end
