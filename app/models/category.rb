class Category < ApplicationRecord
  include Activable

  has_many :item_categories
  has_many :items, through: :item_categories

  validates :name, presence: { message: 'Name cannot be blank' }, uniqueness: { message: 'Category already exists' }
end
