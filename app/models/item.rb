class Item < ApplicationRecord
  
  has_many :grocery_items
  has_many :greocery_stores, through: :grocery_items

  has_many :item_categories
  has_many :categories, through: :item_categories

  mount_uploader :picture, ImageUploader

  validates :name, presence: true, uniqueness: { message: 'Item already exists' }
end
