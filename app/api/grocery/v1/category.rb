class Grocery::V1::Category < Grape::API

  helpers Grocery::V1::Helpers::TimestampHelpers

  params do
    requires :token, type: String, desc: "Authentication Token"
  end

  resource :categories do
    desc "Create a Category"
    params do
      requires :name, type: String, desc: 'Category Name'
      optional :parent_id, type: String, desc: "Sub category parent id"
      optional :description, type: String, desc: "Category Description"
    end
    post "/", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        request = Grocery::V1::Requests::CategoryRequest.call params

        category_repository = CategoryRepository.new
        category = category_repository.create request

        present category, with: Grocery::V1::Entities::CategoryResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Category "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Fetch all active categories"
    get "/", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [500, "Internal Server Error"]
    ] do
      begin
        category_repository = CategoryRepository.new
        categories = category_repository.fetch_all

        present categories, with: Grocery::V1::Entities::CategoryResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Category "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Fetch a category"
    get "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [500, "Internal Server Error"]
    ] do
      begin
        category_repository = CategoryRepository.new
        category = category_repository.fetch params[:id]

        present category, with: Grocery::V1::Entities::CategoryResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Category "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Update a Category"
    params do
      requires :name, type: String, desc: 'Category Name'
      optional :parent_id, type: String, desc: "Sub category parent id"
      optional :description, type: String, desc: "Category Description"
    end
    put "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        request = Grocery::V1::Requests::CategoryRequest.call params

        category_repository = CategoryRepository.new
        category = category_repository.update params[:id], request

        present category, with: Grocery::V1::Entities::CategoryResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Category "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Fetch all active parent categories"
    get "/fetch/parents", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [500, "Internal Server Error"]
    ] do
      begin
        category_repository = CategoryRepository.new
        parent_categories = category_repository.fetch_parent_categories

        present parent_categories, with: Grocery::V1::Entities::CategoryResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Category "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

    desc "Destroy a Category"
    params do
      requires :id, type: Integer, desc: 'Category Id'
    end
    delete "/:id", http_codes: [
      [200, "Ok"],
      [401, "Unauthorized"],
      [404, "Not Found"],
      [500, "Internal Server Error"]
    ] do
      begin
        category_repository = CategoryRepository.new
        category = category_repository.destroy params[:id]

        present category, with: Grocery::V1::Entities::CategoryResponseEntity
      rescue ExceptionService => ex
        Rails.logger.info "---------> Grocery::V1::Category "
        Rails.logger.error ex.inspect
        Rails.logger.error ex.backtrace.join("\n")

        error!({status: 'error', message: ex.message}, 500)
      end
    end

  end
end