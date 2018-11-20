class Address < ApplicationRecord

  before_create :set_country
  
  belongs_to :addressable, polymorphic: true

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

private

  def set_country
    self.country = 'BR'
  end
end
