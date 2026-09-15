Rails.application.configure do
  config.secret_key_base = ENV.fetch("SECRET_KEY_BASE", "test-only-secret-key-base-change-me")
  config.enable_reloading = false
  config.eager_load = false

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false

  config.action_mailer.delivery_method = :test
  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :stderr
end
