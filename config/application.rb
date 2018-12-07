require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
ENV['RAILS_ADMIN_THEME'] = 'rollincode'

module Nextidoacao
	class Application < Rails::Application

    attr_reader :token
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.i18n.default_locale = 'pt-BR'
	   
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.paths << Rails.root.join("app", "assets", "fonts", "dashboard")
    
    end
end


