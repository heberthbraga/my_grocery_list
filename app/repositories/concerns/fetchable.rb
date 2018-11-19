module Fetchable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :object

    private

    def fetchable(object)
      @object = object
    end
  end

  def fetch(id)
    klass = self.class.object.to_s.classify.constantize

    Rails.logger.debug "Repositories::Fetchable#fetch = Fetching #{klass} #{id}"

    begin
      klass.find(id)
    rescue => ex
      response = Handlers::Response.new
      response.handle_error [ex.message]

      return nil
    end
  end
end