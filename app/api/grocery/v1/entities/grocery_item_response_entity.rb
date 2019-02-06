module Grocery::V1::Entities
  class GroceryItemResponseEntity < Grape::Entity
    
    expose :id,            documentation: { type: 'integer', desc: 'Grocery Item ID' }
    expose :grocery_store, documentation: { type: 'Object' }, with: SimplifiedGroceryStoreResponseEntity
    expose :price,         documentation: { type: 'decimal', desc: 'Grocery Item price' }

  end
end