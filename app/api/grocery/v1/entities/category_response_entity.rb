module Grocery::V1::Entities
  class CategoryResponseEntity < Grape::Entity
    
    expose :id,           documentation: { type: 'integer', desc: 'Grocery Store ID' }
    expose :name,         documentation: { type: 'string', desc: 'Category Name' }
    expose :description,  documentation: { type: 'string', desc: 'Category Description' }

  end
end