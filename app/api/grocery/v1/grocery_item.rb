class Grocery::V1::GroceryItem < Grape::API

  params do
    requires :token, type: String, desc: "Authentication Token"
  end

  resource :grocery_items do
    desc "Create an Association between Store and Item"
    params do
      requires :grocery_store_id, type: Integer, desc: 'Grocery Store Id'
      requires :item_id, type: Integer, desc: 'Item id'
      requires :price, type: BigDecimal, desc: 'Item price for that Store'
    end
    post "/", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        request = Grocery::V1::Requests::GroceryItemRequest.call params

        grocery_item_repository = GroceryItemRepository.new
        grocery_item = grocery_item_repository.create request

        present grocery_item, with: Grocery::V1::Entities::GroceryItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::GroceryItem "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Destroy an Association between Store and Item"
    params do
      requires :id, type: Integer, desc: 'Grocery Item Association Id'
    end
    delete "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        grocery_item_repository = GroceryItemRepository.new
        grocery_item = grocery_item_repository.destroy params[:id]
  
        present grocery_item, with: Grocery::V1::Entities::GroceryItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::GroceryItem "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end
  end
end