module Grocery::V1::Entities
  class GroceryStoreResponseEntity < Grape::Entity
    
    expose :id,           documentation: { type: 'integer', desc: 'Grocery Store ID' }
    expose :name,         documentation: { type: 'string', desc: 'Grocery Store Name' }
    expose :fantasy_name, documentation: { type: 'string', desc: 'Grocery Store Fantasy Name' }
    expose :website,      documentation: { type: 'string', desc: 'Grocery Store Website' }
    
  end
end