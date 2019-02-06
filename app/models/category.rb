class Category < ApplicationRecord
  include Activable

  has_many :item_categories
  has_many :items, through: :item_categories

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category', optional: true

  scope :fetch_parent_categories, -> { where(parent: nil).active }

  validates :name, presence: { message: 'Name cannot be blank' }, uniqueness: { message: 'Category already exists' }

  def subcategory?
    self.parent.present?
  end

end
