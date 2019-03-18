class API::Authorization < ApplicationService

  def initialize(access_token)
    @access_token = access_token
  end

  def call
    current_user = nil

    api_key = ApiKey.find_by(access_token: @access_token)

    if api_key
      raise ExceptionService.new('Invalid or Expired Token.') if api_key.expired?
      
      current_user = User.find_by(id: api_key.user_id, active: true)
    end

    if current_user.present?
      return current_user
    else
      raise ExceptionService.new('Unauthorized.')
    end
  end
end