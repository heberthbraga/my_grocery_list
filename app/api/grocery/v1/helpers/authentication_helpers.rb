module Grocery::V1::Helpers
  module AuthenticationHelpers
    extend Grape::API::Helpers

    def authorize!
      begin
        @current_user = API::Authorization.call params[:token]
      rescue ExceptionService => ex
        error!({status: 'error', message: ex.message}, 401)
      end
    end
  end
end