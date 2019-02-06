class ExceptionService < StandardError
  attr_accessor :error_code

  def initialize(error_message, error_code = nil)
    super(error_message)
    @error_code = error_code
  end
end