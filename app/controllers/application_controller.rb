class ApplicationController < ActionController::API

  def index
    redirect_to grape_swagger_rails_path
  end
end
