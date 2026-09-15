Rails.application.configure do
  config.secret_key_base = ENV.fetch("SECRET_KEY_BASE", "development-only-secret-key-base-change-me")
  config.enable_reloading = true
  config.eager_load = false

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :memory_store

  config.active_record.migration_error = :page_load
  config.active_support.deprecation = :log

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false

  config.assets.debug = true
  config.assets.quiet = true
end
