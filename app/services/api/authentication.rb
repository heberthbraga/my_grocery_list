AuthenticationError = Class.new(StandardError)

class API::Authentication < ApplicationService

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    Rails.logger.debug "API::Authentication = Authenticating user #{@username}"

    existing_user = User.find_by(email: @username)

    if existing_user && existing_user.authenticate(@password) && existing_user.api?
      key = ApiKey.create(user_id: existing_user.id)

      Rails.logger.debug "API::Authentication = User authenticated with Key #{key.inspect}"

      {
        token: key.access_token
      }
    else
      raise AuthenticationError.new('Failed to authenticate user.')
    end
  end
end