class Category < ApplicationRecord
  include Activable

  has_many :item_categories
  has_many :items, through: :item_categories

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category', optional: true

  validates :name, presence: { message: 'Name cannot be blank' }, uniqueness: { message: 'Category already exists' }
end
