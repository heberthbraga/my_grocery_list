class CategoryRepository
  include Fetchable
  fetchable :category

  def initialize
  end

  def create(category_request)
    Rails.logger.debug "CategoryRepository#create = Creating Category #{category_request}"

    category = Category.new(category_request)

    category.save!

    category
  end

  def fetch_all
    active_categories = Category.active

    Rails.logger.debug "CategoryRepository#fetch_all = Fetching #{active_categories.size} Category(ies)"

    active_categories
  end

private

  attr_reader :category_request

end