class ItemRepository
  include Persistable
  persistable :item
  
  def fetch_all_by clause, direction=:desc
    Rails.logger.debug "=======> ItemRepository#fetch_all_by = Fetching items for clause=#{clause}; direction=#{direction}"

    case clause
    when :price
      Item.fetch_all_by_price direction
    else
      []
    end
  end

  def fetch_all_not_matched_store store_id
    Rails.logger.debug "=======> ItemRepository#fetch_all_not_matched_store = Fetching items for Store=#{store_id}"

    Item.all.reject{ |item| item.match_grocery_store?(store_id) }
  end

  def search keyword
    Rails.logger.debug "=======> ItemRepository#search = Searching with keyword=#{keyword}"
    
    Item.search keyword
  end

  def fetch_history item_id
    item = Item.find(item_id)

    Rails.logger.debug "=======> ItemRepository#fetch_history = Fetching history for Item #{item}"

    item.history
  end
end