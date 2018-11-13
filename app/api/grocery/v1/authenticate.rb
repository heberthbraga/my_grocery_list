class Grocery::V1::Authenticate < Grape::API

  desc "Creates and returns access_token if login and password are valid"
  params do
    requires :username, type: String, desc: "Username or Email address"
    requires :password, type: String, desc: "Password"
  end

  post :login do
    existing_user = User.find_by(email: params[:username])

    if existing_user && existing_user.valid_password?(params[:password]) && existing_user.api?
      key = ApiKey.create(user_id: user.id)

      { 
        token: key.access_token
      }
    else
      error!('Failed to authenticate user.', 401)
    end
  end
end