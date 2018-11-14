UnauthorizedError = Class.new(StandardError)

class API::Authorization < ApplicationService

  def initialize(access_token)
    @access_token = access_token
  end

  def call
    current_user = nil

    api_key = ApiKey.find_by(access_token: @access_token)

    if api_key && !api_key.expired?
      current_user = User.find_by(id: api_key.user_id, active: true)
    end

    if current_user.present? && current_user.api?
      return current_user
    else
      raise UnauthorizedError.new('Unauthorized. Invalid or expired token.')
    end
  end
end