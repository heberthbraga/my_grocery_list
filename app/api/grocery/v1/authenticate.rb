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

  post :login do
    begin
      authenticate = API::Authentication.new(params[:username], params[:password])
      response = authenticate.call

      present response, with: Grocery::V1::Entities::AuthenticationResponseEntity
    rescue ExceptionService => ex
      error!({status: 'error', message: ex.message}, 401)
    end
  end
end