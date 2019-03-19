module Grocery::V1::Entities
  class CategoryResponseEntity < Grape::Entity
    
    expose :id,            documentation: { type: 'Integer', desc: 'Grocery Store ID' }
    expose :name,          documentation: { type: 'String', desc: 'Category Name' }
    expose :description,   documentation: { type: 'String', desc: 'Category Description' }
    expose :parent_id,     documentation: { type: 'Integer', desc: 'Parent Category Id' }
    expose :subcategories, documentation: { type: 'Array', desc: 'Category Description' }, with: self
    expose(:subcategory,   documentation: { type: 'Boolean', desc: 'Check if subcategory'}) do |category, ops|
      category.subcategory?
    end 
    
    expose(:subcategory,   documentation: { type: 'Boolean', desc: 'Check if subcategory'}) do |category, ops|
      category.subcategory?
    end 
    
    with_options(format_with: :partial_timestamp) do
      expose :created_at, documentation: { type: 'Datetime', desc: 'Category creation date' }
      expose :updated_at, documentation: { type: 'Datetime', desc: 'Category update date' }
    end
  end
end