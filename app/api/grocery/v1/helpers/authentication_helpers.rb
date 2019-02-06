module Grocery::V1::Helpers
  module AuthenticationHelpers
    extend Grape::API::Helpers

    def authorize!
      begin
        @current_user = API::Authorization.call params[:token]
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Authorization "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 401)
      end
    end
  end
end