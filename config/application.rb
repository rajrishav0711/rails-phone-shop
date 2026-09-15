require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module RailsPhoneShopCandidateRajrishav0711C5b53815de362f0693425cb26cf0c2cc
  class Application < Rails::Application
    config.load_defaults 8.1
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
