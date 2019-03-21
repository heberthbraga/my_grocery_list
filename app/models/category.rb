class Category < ApplicationRecord
  include Activable

  has_many :item_categories
  has_many :items, through: :item_categories

  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category', optional: true

  scope :fetch_parent_categories, -> { where(parent: nil).active }

  validates :name, presence: { message: 'Name cannot be blank' }
  validates :name, uniqueness: { message: 'Category already exists' }, on: :create

  def subcategory?
    self.parent.present?
  end

  def items_history
    {
      name: self.name,
      items_history: self.items.collect{|item| item.history }.compact
    }
  end
end
