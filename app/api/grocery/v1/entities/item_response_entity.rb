module Grocery::V1::Entities
  class ItemResponseEntity < Grape::Entity
    
    expose :id,            documentation: { type: 'Integer', desc: 'Item ID' }
    expose :categories,    documentation: { type: 'Array', desc: 'List of categories' }, with: CategoryResponseEntity
    expose :name,          documentation: { type: 'String', desc: 'Item Name' }
    expose :picture,       documentation: { type: 'String', desc: 'Item Picture' }
    expose :grocery_items, documentation: { type: 'Array', desc: 'Grocery items collection' }, with: GroceryItemResponseEntity
    expose :lowest_price,  documentation: { type: 'Decimal', desc: 'Item lowest price' }
    expose :created_at,    documentation: { type: 'Datetime', desc: 'Category creation date' }, format_with: :date_timestamp

  end
end