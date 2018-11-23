module Persistable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :object

    private

    def persistable(object)
      @object = object.to_s.classify.constantize
    end
  end

  def create(params)
    Rails.logger.debug "Repositories::Persistable#create = Creating #{self.class.object} #{params}"

    target_object = self.class.object.new(params)

    if target_object.save
      target_object
    else
      raise ExceptionService.new("#{target_object.errors.messages.map{|k, v| v}.join(', ')}")
    end
  end

  def fetch(id)
    Rails.logger.debug "Repositories::Persistable#fetch = Fetching #{self.class.object} #{id}"

    begin
      self.class.object.find(id)
    rescue => ex
      response = Handlers::Response.new
      response.handle_error [ex.message]

      return nil
    end
  end

  def fetch_all
    active_objects = self.class.object.active

    Rails.logger.debug "Repositories::Persistable#fetch_all = Fetching #{active_objects.size} #{self.class.object}(ies)"

    active_objects
  end

  def update(id, params)
    Rails.logger.debug "CategoryRepository#update = Updating #{self.class.object} #{id} with #{params}"

    target_object = self.class.object.find(id)

    if target_object.update(params)
      target_object
    else
      raise ExceptionService.new("#{target_object.errors.messages.map{|k, v| v}.join(', ')}")
    end
  end

  def destroy(id)
    Rails.logger.debug "Repositories::Persistable#destroy = Destroying #{self.class.object} #{id}"

    target_object = self.class.object.find(id)

    target_object.destroy
  end
end