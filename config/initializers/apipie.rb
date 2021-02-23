Apipie.configure do |config|
  config.app_name                = "ApiSampleApp"
  config.app_info = "This is document for api app ApiSampleApp"
  config.copyright = "&copyright VEU"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/docs"
  config.translate = false
  config.reload_controllers = true
  config.api_routes = Rails.application.routes
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
end
