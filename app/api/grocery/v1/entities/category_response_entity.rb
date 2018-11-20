module Grocery::V1::Entities
  class CategoryResponseEntity < Grape::Entity
    
    expose :id,           documentation: { type: 'integer', desc: 'Grocery Store ID' }
    expose :name,         documentation: { type: 'string', desc: 'Category Name' }
    expose :description,  documentation: { type: 'string', desc: 'Category Description' }
    
    with_options(format_with: :partial_timestamp) do
      expose :created_at, documentation: { type: 'datetime', desc: 'Category creation date' }
      expose :updated_at, documentation: { type: 'datetime', desc: 'Category update date' }
    end
  end
end