class CategoryRepository
  include Persistable
  persistable :category
  
  def fetch_parent_categories
    parent_categories = Category.fetch_parent_categories

    Rails.logger.debug "CategoryRepository#fetch_parent_categories = Fetching #{parent_categories.size} Category(ies)"

    parent_categories
  end

  def fetch_items_history
    categories_items_history = Category.all.collect{|category| category.items_history }
      .reject{|item| item[:items_history].empty? }

    Rails.logger.debug "CategoryRepository#fetch_items_history = Fetching items history #{categories_items_history.size} Category(ies)"
  
    categories_items_history
  end
end