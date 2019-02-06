class User < ApplicationRecord
  include Activable

  has_secure_password
  
  belongs_to :role

  validates :role, presence: true
  validates :first_name, presence: { message: "First name can't be blank" }
  validates :last_name, presence: { message: "Last name can't be blank" }
  validates :email, presence: { message: "Email can't be blank" }, email: true, uniqueness: { message: 'Email is unique' }

  def api?
    self.role.present? && self.role.name === Role.api
  end
end
