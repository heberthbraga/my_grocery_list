module Grocery::V1::Helpers
  module TimestampHelpers
    extend Grape::API::Helpers

    Grape::Entity.format_with :partial_timestamp do |date|
      date.strftime("%d/%m/%Y %H:%M") if date
    end

    Grape::Entity.format_with :date_timestamp do |date|
      date.strftime("%d/%m/%Y") if date
    end
  end
end