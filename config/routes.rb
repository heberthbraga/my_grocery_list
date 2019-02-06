Rails.application.routes.draw do

  root to: 'application#index'

  mount GrapeSwaggerRails::Engine => '/swagger'
  mount API => '/'
end
