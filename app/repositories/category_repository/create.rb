class CategoryRepository::Create < ApplicationService

  def initialize(category_request)
    @category_request = category_request
  end

  def call
    category = Category.new(@category_request)

    response = Handlers::Response.new(category)

    if category.save
      response.handle_success
    else
      Rails.logger.error "CategoryRepository::Create = Error trying to save Category #{category.inspect}"
      response.handle_error category.errors.full_messages.join(" || ")
    end

    response
  end
end