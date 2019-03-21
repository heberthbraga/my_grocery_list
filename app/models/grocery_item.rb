class GroceryItem < ApplicationRecord

  belongs_to :grocery_store
  belongs_to :item

  validates :price, presence: { message: 'Price cannot be blank' }, numericality: { greater_than: 0 }
  validates :item, presence: true
  validates :grocery_store, presence: true

  has_paper_trail :on => [:update, :destroy]

  scope :grouped_versions, -> { PaperTrail::Version.where(item_type: 'GroceryItem') }

  default_scope { order('price ASC') }

  class << self
    def versions_by_item item_id
      grouped_versions.collect do |version|
        target_object = version.reify
        target_object if target_object && target_object.item_id === item_id
      end.compact
    end
  end

  def get_last_version
    self.versions.last
  end
end
