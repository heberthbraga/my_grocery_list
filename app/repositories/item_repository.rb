class ItemRepository
  include Persistable
  persistable :item
  
  def fetch_all_by(clause, direction=:desc)
    case clause
    when :price
      Item.fetch_all_by_price direction
    else
      []
    end
  end

  def fetch_all_not_matched_store store_id
    Item.all.reject{ |item| item.match_grocery_store?(store_id) }
  end
end