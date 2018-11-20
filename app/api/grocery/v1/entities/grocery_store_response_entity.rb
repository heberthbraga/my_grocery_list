module Grocery::V1::Entities
  class GroceryStoreResponseEntity < Grape::Entity
    
    expose :id,           documentation: { type: 'integer', desc: 'Grocery Store ID' }
    expose :name,         documentation: { type: 'string', desc: 'Grocery Store Name' }
    expose :fantasy_name, documentation: { type: 'string', desc: 'Grocery Store Fantasy Name' }
    expose :website,      documentation: { type: 'string', desc: 'Grocery Store Website' }
    
    with_options(format_with: :partial_timestamp) do
      expose :created_at, documentation: { type: 'datetime', desc: 'Grocery Store creation date' }
      expose :updated_at, documentation: { type: 'datetime', desc: 'Grocery Store update date' }
    end
  end
end