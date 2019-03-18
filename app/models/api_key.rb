class ApiKey < ApplicationRecord

  before_create :generate_access_token
  before_create :set_expiration

  belongs_to :user

  def expired?
    DateTime.now >= self.expires_at
  end

  def refresh
    generate_access_token
    set_expiration
  end

private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: self.access_token)
  end

  def set_expiration
    self.expires_at = DateTime.now + 30
  end
end
