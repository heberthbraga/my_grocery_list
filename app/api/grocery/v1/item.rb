class Grocery::V1::Item < Grape::API

  params do
    requires :token, type: String, desc: "Authentication Token"
  end

  resource :items do
    desc "Create an Item"
    params do
      requires :category_ids, type: Array[Integer], desc: 'List of selected category ids'
      requires :name, type: String, desc: 'Item name'
      optional :pciture, type: String, desc: "Item's picture"
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
        error!({status: 'error', message: ex.message}, 401)
      rescue Exception => e
        error!({status: 'error', message: e.message}, 500)
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
        error!({status: 'error', message: ex.message}, 401)
      rescue Exception => e
        error!({status: 'error', message: e.message}, 500)
      end
    end

    desc "Fetch an existing Item"
    get "/:id", http_codes: [
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
        error!({status: 'error', message: ex.message}, 401)
      rescue Exception => e
        error!({status: 'error', message: e.message}, 500)
      end
    end
  end
end