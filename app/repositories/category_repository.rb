class CategoryRepository
  include Persistable
  persistable :category
  
  def fetch_parent_categories
    parent_categories = Category.fetch_parent_categories

    Rails.logger.debug "CategoryRepository#fetch_parent_categories = Fetching #{parent_categories.size} Category(ies)"

    parent_categories
  end
end