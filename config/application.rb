# frozen_string_literal: true

require File.expand_path("boot", __dir__)

require "rails/all"
require "active_record/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BiblestudyPlatform
  # Basic settings on localization
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record
    # auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    config.time_zone = "Amsterdam"

    # The default locale is :en and all translations from
    # config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path +=
      Dir[Rails.root.join("config", "locales", "lib", "**", "*.{rb,yml}")]
    config.i18n.default_locale = :nl

    # Add i18n also for Javascript
    # config.middleware.use I18n::JS::Middleware

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.assets.initialize_on_precompile = false

    config.encoding = "utf-8"

    config.action_dispatch.default_headers[
      "Permissions-Policy"
    ] = "interest-cohort=()"

    config.active_record.legacy_connection_handling = false

    config.generators { |gen| gen.template_engine :haml }
  end
end
