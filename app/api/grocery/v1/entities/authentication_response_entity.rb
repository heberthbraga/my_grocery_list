module Grocery::V1::Entities
  class AuthenticationResponseEntity < Grape::Entity
    expose :token
  end
end