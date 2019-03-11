class Item < ApplicationRecord
  include Activable

  before_save :map_categories

  attr_accessor :category_ids

  has_many :grocery_items, dependent: :destroy
  has_many :grocery_stores, through: :grocery_items

  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  mount_uploader :picture, ImageUploader

  scope :fetch_all_by_price, -> (direction) { joins(:grocery_items).order("grocery_items.price #{direction}").uniq }
  scope :fetch_all_not_matched_store, -> (store_id) { joins(:grocery_stores).where('grocery_stores.id <> ?', store_id) }
  
  validates :name, presence: { message: 'Product can\'t be blank' }, uniqueness: { message: 'Item already exists' }
  validates :quantity, presence: { message: 'Quantity can\'t be blank' }
  validates_with CategoriesValidator

  def lowest_store_price
    lowest = self.grocery_items.first

    lowest.present? ? { store: lowest.grocery_store.name, price: lowest.price } : {}
  end

  def match_grocery_store? store_id
    self.grocery_stores.where(grocery_stores: { id: store_id }).first.present?
  end

  def prices_per_store
    self.grocery_items.collect{|grocery_item| { store: grocery_item.grocery_store.name, price: grocery_item.price } }
  end

private

  def map_categories
    unmatched_category_ids = self.category_ids - self.categories.pluck(:id)
    unmatched_category_ids.each{ |category_id| self.item_categories.build(category_id: category_id) }
  end
end
