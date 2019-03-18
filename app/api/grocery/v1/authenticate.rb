class Grocery::V1::Authenticate < Grape::API

  desc "Creates and returns a token if login and password are valid" do
    detail "
      INPUT:

      {
        \"username\": (email),
        \"password\": (password)
      }

      RESPONSE: 

      {
        \"token\": (access_token)
      }
    "
  end
  params do
    requires :username, type: String, desc: "Username or Email address"
    requires :password, type: String, desc: "Password"
  end

  post :login, http_codes: [
    [200, "Ok"],
    [500, "Internal Server Error"]
  ] do
    begin
      response = API::Authentication.call params[:username], params[:password]

      present response, with: Grocery::V1::Entities::AuthenticationResponseEntity
    rescue ExceptionService => ex
      Rails.logger.info "---------> Grocery::V1::Authenticate#login "
      Rails.logger.error ex.inspect
      Rails.logger.error ex.backtrace.join("\n")

      error!({status: 'error', message: ex.message}, 401)
    rescue Exception => e
      Rails.logger.info "---------> Grocery::V1::Authenticate#login "
      Rails.logger.error e.inspect
      Rails.logger.error e.backtrace.join("\n")
      
      error!({status: 'error', message: e.message}, 500)
    end
  end

  desc "Returns a new access token" do
    detail "
      RESPONSE: 

      {
        \"token\": (access_token)
      }
    "
  end
  params do
    requires :expired_token, type: String, desc: "Expired Token"
  end
  post :refresh_token, http_codes: [
    [200, "Ok"],
    [404, 'Not Found']
  ] do
    begin
      response = API::RefreshToken.call params[:expired_token]

      present response, with: Grocery::V1::Entities::AuthenticationResponseEntity
    rescue ExceptionService => ex
      Rails.logger.info "---------> Grocery::V1::Authenticate#refresh_token "
      Rails.logger.error ex.inspect
      Rails.logger.error ex.backtrace.join("\n")

      error!({status: 'error', message: ex.message}, 404)
    end
  end
end