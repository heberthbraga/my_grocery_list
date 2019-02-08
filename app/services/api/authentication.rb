class API::Authentication < ApplicationService

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    raise ExceptionService.new('Email can\'t be blank.') unless username.present?
    raise ExceptionService.new('Password can\'t be blank.') unless password.present?

    Rails.logger.debug "API::Authentication = Authenticating user #{username}"

    existing_user = User.find_by(email: username)

    if existing_user && existing_user.authenticate(password) && existing_user.api?
      key = ApiKey.create(user_id: existing_user.id)

      Rails.logger.debug "API::Authentication = User authenticated with Key #{key.inspect}"

      {
        token: key.access_token
      }
    else
      raise ExceptionService.new('Failed to authenticate user.')
    end
  end

private

  attr_reader :username, :password
  
end