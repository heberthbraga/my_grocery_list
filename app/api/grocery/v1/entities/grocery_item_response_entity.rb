module Grocery::V1::Entities
  class GroceryItemResponseEntity < Grape::Entity
    
    expose :id,            documentation: { type: 'integer',  desc: 'Grocery Item ID' }
    expose :price,         documentation: { type: 'decimal',  desc: 'Grocery Item price' }
    expose :item,          documentation: { type: 'Object' }, with: ItemResponseEntity
    
  end
end