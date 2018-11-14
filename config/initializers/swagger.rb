GrapeSwaggerRails.options.url = '/api/v1/swagger_doc'

# base_url = ActionMailer::Base.default_url_options[:host]

commit = `git rev-parse --short HEAD`

GrapeSwaggerRails.options.doc_url = "/swagger"
GrapeSwaggerRails.options.app_url  = '/'
GrapeSwaggerRails.options.app_name = 'MY GROCERY LIST API - ' + commit
