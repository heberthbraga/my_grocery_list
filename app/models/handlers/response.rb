class Handlers::Response

  attr_accessor :success, :entity

  def initialize(entity=nil)
    @entity = entity
  end

  def handle_success
    @success = true
  end

  def handle_error(messages)
    @success = false

    unless messages.empty?
      Rails.logger.error "Handlers::Response : Errors=#{messages.inspect}"
    end
  end

end