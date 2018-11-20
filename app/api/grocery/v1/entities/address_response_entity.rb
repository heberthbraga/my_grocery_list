module Grocery::V1::Entities
  class AddressResponseEntity < Grape::Entity

    expose :id,         documentation: { type: 'integer', desc: 'Address ID' }
    expose :street,     documentation: { type: 'string', desc: 'Address street' }
    expose :city,       documentation: { type: 'string', desc: 'Address City' }
    expose :state,      documentation: { type: 'string', desc: 'Address State' }
    expose :zip,        documentation: { type: 'string', desc: 'Address zip code' }
    
  end
end