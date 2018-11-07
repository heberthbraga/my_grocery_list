class Address < ApplicationRecord

  before_create :set_country
  
  belongs_to :addressable, polymorphic: true

private

  def set_country
    self.country = 'BR'
  end
end
