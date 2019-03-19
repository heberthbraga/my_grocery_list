class Grocery::V1::Item < Grape::API

  helpers Grocery::V1::Helpers::TimestampHelpers
  
  params do
    requires :token, type: String, desc: "Authentication Token"
  end

  resource :items do
    desc "Create an Item"
    params do
      requires :category_ids, type: String, desc: 'List of selected category ids separated by comma'
      requires :name, type: String, desc: 'Item name'
      optional :picture, type: File, desc: "Item's picture"
    end
    post "/", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        request = Grocery::V1::Requests::ItemRequest.call params

        item_repository = ItemRepository.new
        item = item_repository.create request

        present item, with: Grocery::V1::Entities::ItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Item "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Fetch all active Items" do
    end
    get "/", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [500, "Internal Server Error"]
    ] do
      begin
        item_repository = ItemRepository.new
        items = item_repository.fetch_all

        present items, with: Grocery::V1::Entities::ItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Item "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Fetch an existing Item"
    get "/fetch/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        item_repository = ItemRepository.new
        item = item_repository.fetch params[:id]

        present item, with: Grocery::V1::Entities::ItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Item /fetch "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Update an Item"
    params do
      requires :category_ids, type: String, desc: 'List of selected category ids separated by comma'
      requires :name, type: String, desc: 'Item name'
      optional :pciture, type: File, desc: "Item's picture"
    end
    put "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        request = Grocery::V1::Requests::ItemRequest.call params

        item_repository = ItemRepository.new
        item = item_repository.update params[:id], request

        present item, with: Grocery::V1::Entities::ItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Item /put "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Fetching highligth items"
    get "/highlights", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        item_repository = ItemRepository.new
        items = item_repository.fetch_all_by :price

        present items, with: Grocery::V1::Entities::ItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Item /highlights "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Fetching items that don't belong to a store"
    params do
      requires :store_id, type: Integer, desc: 'Grocery Store Id'
    end
    get "/fetch/not_matched_store/:store_id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        item_repository = ItemRepository.new
        items = item_repository.fetch_all_not_matched_store params[:store_id]

        present items, with: Grocery::V1::Entities::ItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Item /fetch/not_matched_store"
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Search items based on keyword"
    params do
      requires :keyword, type: String, desc: 'Search keyword'
    end
    post "/search", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [500, "Internal Server Error"]
    ] do
      begin
        item_repository = ItemRepository.new
        items = item_repository.search params[:keyword]

        present items, with: Grocery::V1::Entities::ItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Item /search "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Destroy an Item"
    params do
      requires :id, type: Integer, desc: 'Item Id'
    end
    delete "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        item_repository = ItemRepository.new
        item = item_repository.destroy params[:id]
  
        present item, with: Grocery::V1::Entities::ItemResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Item "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

  end
end