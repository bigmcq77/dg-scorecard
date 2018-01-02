JSONAPI.configure do |config|
  config.default_processor_klass = JSONAPI::Authorization::AuthorizingProcessor
  config.exception_class_whitelist = [Pundit::NotAuthorizedError]
  config.top_level_meta_include_page_count = true
  config.top_level_meta_page_count_key = :page_count

  config.default_paginator = :paged
end
