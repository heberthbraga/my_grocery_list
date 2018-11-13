class CategoryRepository::FetchAll < ApplicationService

  def call
    Category.active
  end
end