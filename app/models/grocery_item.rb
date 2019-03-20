class GroceryItem < ApplicationRecord

  belongs_to :grocery_store
  belongs_to :item

  validates :price, presence: { message: 'Price cannot be blank' }, numericality: { greater_than: 0 }
  validates :item, presence: true
  validates :grocery_store, presence: true

  has_paper_trail :on => [:update, :destroy]

  scope :versions, -> { PaperTrail::Version.where(item_type: 'GroceryItem') }

  default_scope { order('price ASC') }

  def get_last_version
    self.versions.last
  end
end
