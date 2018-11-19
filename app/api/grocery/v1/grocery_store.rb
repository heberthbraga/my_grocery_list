class Grocery::V1::GroceryStore < Grape::API

  params do
    requires :token, type: String, desc: "Authentication Token"
  end

  resource :stores do
    desc "Create a grocery Store"
    params do
      requires :name, type: String, desc: 'Store name'
      requires :fantasy_name, type: String, desc: "Store's fantasy name"
      optional :website, type: String, desc: "Store's website"
    end
    post "/", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        request = Grocery::V1::Requests::GroceryStoreRequest.call params

        grocery_store_repository = GroceryStoreRepository.new
        grocery_store = grocery_store_repository.create request

        present grocery_store, with: Grocery::V1::Entities::GroceryStoreResponseEntity
      rescue ExceptionService => ex
        error!({status: 'error', message: ex.message}, 401)
      rescue Exception => e
        error!({status: 'error', message: e.message}, 500)
      end
    end

    desc "Fetch all active stores" do
    end
    get "/", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [500, "Internal Server Error"]
    ] do
      begin
        grocery_store_repository = GroceryStoreRepository.new
        grocery_stores = grocery_store_repository.fetch_all

        present grocery_stores, with: Grocery::V1::Entities::GroceryStoreResponseEntity
      rescue ExceptionService => ex
        error!({status: 'error', message: ex.message}, 401)
      rescue Exception => e
        error!({status: 'error', message: e.message}, 500)
      end
    end

    desc "Fetch an existing Store"
    get "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        grocery_store_repository = GroceryStoreRepository.new
        grocery_store = grocery_store_repository.fetch params[:id]

        present grocery_store, with: Grocery::V1::Entities::GroceryStoreResponseEntity
      rescue ExceptionService => ex
        error!({status: 'error', message: ex.message}, 401)
      rescue Exception => e
        error!({status: 'error', message: e.message}, 500)
      end
    end
  end

end