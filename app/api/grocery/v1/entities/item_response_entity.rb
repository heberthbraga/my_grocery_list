module Grocery::V1::Entities
  class ItemResponseEntity < Grape::Entity
    
    expose :id,           documentation: { type: 'integer', desc: 'Item ID' }
    expose :categories,   with: CategoryResponseEntity, documentation: { type: 'array', desc: 'List of categories' }
    expose :name,         documentation: { type: 'string', desc: 'Item Name' }
    expose :picture,      documentation: { type: 'string', desc: 'Item Picture' }

  end
end