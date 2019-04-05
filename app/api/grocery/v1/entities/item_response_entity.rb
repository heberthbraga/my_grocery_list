module Grocery::V1::Entities
  class ItemResponseEntity < Grape::Entity
    
    expose :id,                     documentation: { type: 'Integer', desc: 'Item ID' }
    expose :categories,             documentation: { type: 'Array', desc: 'List of categories' }, with: CategoryResponseEntity
    expose :name,                   documentation: { type: 'String', desc: 'Item Name' }
    expose :picture,                documentation: { type: 'String', desc: 'Item Picture' }
    expose :quantity,               documentation: { type: 'Integer', desc: 'Item quantity' }
    expose :lowest_store_price,     documentation: { type: 'Decimal', desc: 'Item lowest price' }
    expose :created_at,             documentation: { type: 'Datetime', desc: 'Category creation date' }, format_with: :date_timestamp
    expose :category_ids,           documentation: { type: 'Array', desc: 'List of category ids' }
    expose :history,                documentation: { type: 'Object', desc: 'Item history' } do |item, opts|
      item.history
    end
    expose(:prices_per_store,       documentation: { type: 'Object', desc: 'List prices per Store' }) do |item, opts|
      item.prices_per_store
    end
    
  end
end