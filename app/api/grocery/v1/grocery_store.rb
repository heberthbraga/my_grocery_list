class Grocery::V1::GroceryStore < Grape::API

  helpers Grocery::V1::Helpers::TimestampHelpers
  
  params do
    requires :token, type: String, desc: "Authentication Token"
  end

  resource :stores do
    desc "Create a grocery Store"
    params do
      requires :name, type: String, desc: 'Store name'
      requires :fantasy_name, type: String, desc: "Store's fantasy name"
      optional :website, type: String, desc: "Store's website"
      optional :logo, type: File, desc: "Store logo"
      optional :address, type: Hash do
        optional :street, type: String, desc: "Address street"
        optional :city, type: String, desc: "Address city"
        optional :state, type: String, desc: "Address state"
        optional :zip, type: String, desc: "Address zip code"
      end
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
        Rails.logger.info "---------> Grocery::V1::GroceryStore "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
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
        Rails.logger.info "---------> Grocery::V1::GroceryStore "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
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
        Rails.logger.info "---------> Grocery::V1::GroceryStore "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Update a grocery Store"
    params do
      requires :name, type: String, desc: 'Store name'
      requires :fantasy_name, type: String, desc: "Store's fantasy name"
      optional :website, type: String, desc: "Store's website"
      optional :logo, type: File, desc: "Store logo"
      optional :address, type: Hash do
        optional :street, type: String, desc: "Address street"
        optional :city, type: String, desc: "Address city"
        optional :state, type: String, desc: "Address state"
        optional :zip, type: String, desc: "Address zip code"
      end
    end
    put "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        request = Grocery::V1::Requests::GroceryStoreRequest.call params

        grocery_store_repository = GroceryStoreRepository.new
        grocery_store = grocery_store_repository.update params[:id], request

        present grocery_store, with: Grocery::V1::Entities::GroceryStoreResponseEntity
      rescue Exception => e
        Rails.logger.info "---------> Grocery::V1::GroceryStore "
        Rails.logger.error e.inspect
        Rails.logger.error e.backtrace.join("\n")

        error!({status: 'error', message: e.message}, 500)
      end
    end

    desc "Destroy a Store"
    params do
      requires :id, type: Integer, desc: 'Store Id'
    end
    delete "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        grocery_store_repository = GroceryStoreRepository.new
        grocery_store = grocery_store_repository.destroy params[:id]

        present grocery_store, with: Grocery::V1::Entities::GroceryStoreResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::GroceryStore "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end
  end
end