class Item < ApplicationRecord
  include Activable

  before_save :map_categories

  attr_accessor :category_ids

  has_many :grocery_items, dependent: :destroy
  has_many :greocery_stores, through: :grocery_items

  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  mount_uploader :picture, ImageUploader

  validates :name, presence: { message: 'Item can\'t be blank' }, uniqueness: { message: 'Item already exists' }
  validates_with CategoriesValidator

private

  def map_categories
    unmatched_category_ids = self.category_ids - self.categories.pluck(:id)
    unmatched_category_ids.each{ |category_id| self.item_categories.build(category_id: category_id) }
  end
end
