class Address < ApplicationRecord

  before_create :set_country
  
  belongs_to :addressable, polymorphic: true

  validates :street, presence: {message: 'Street can\'t be blank'}
  validates :city, presence: {message: 'City can\'t be blank'}
  validates :state, presence: {message: 'State can\'t be blank'}
  validates :zip, presence: {message: 'Zip can\'t be blank'}

private

  def set_country
    self.country = 'BR'
  end
end
