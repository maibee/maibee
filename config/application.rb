require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module Maibee
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = 'Asia/Taipei'
    config.i18n.default_locale = 'zh-TW'
    # config.i18n.available_locales = ['zh-TW', :en]
    config.generators do |g|
      g.helper false
      g.test_framework false
      g.assets false
    end
  end
end
