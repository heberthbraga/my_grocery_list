class ItemCategory < ApplicationRecord

  belongs_to :category
  belongs_to :item

  validates :category, presence: { message: 'Category can\'t be blank.' }
end
