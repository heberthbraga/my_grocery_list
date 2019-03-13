module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :query_attributes

    def search keyword
      where(query_attributes, keyword: "%#{keyword}%")
    end
    
    private

    def searchable *attributes
      @query_attributes = attributes.collect{|attribute| 
        "#{attribute.to_s} LIKE :keyword" 
      }.join(' OR ')
    end
  end
end