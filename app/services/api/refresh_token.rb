class API::RefreshToken < ApplicationService

  def initialize expired_token
    @expired_token = expired_token
  end

  # Refresh token and get a new one
  def call
    api_key = ApiKey.find_by(access_token: @expired_token)

    if api_key.present?
      api_key.refresh
      api_key.save

      {
        token: api_key.access_token
      }
    else
      raise ExceptionService.new('Invalid Token.')
    end
  end
end