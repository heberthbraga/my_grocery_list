class Role < ApplicationRecord

  TYPES = {
    'API' => 'API'
  }

  class << self
    def api
      TYPES['API']
    end
  end
end
