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
end