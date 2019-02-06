module Grocery::V1::Entities
  class SimplifiedGroceryStoreResponseEntity < Grape::Entity
    
    expose :id,           documentation: { type: 'integer', desc: 'Grocery Store ID' }
    expose :name,         documentation: { type: 'string', desc: 'Grocery Store Name' }
    expose :address,      documentation: { type: 'object', desc: 'Address object information' }, with: AddressResponseEntity
  end
end