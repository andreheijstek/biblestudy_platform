# frozen_string_literal: true

# This file is copied to spec/ when you run "rails generate rspec:install"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
require "rspec/rails"

# Add additional requires below this line. Rails is not loaded until this point!
require "spec_helper"
require "pundit/rspec"
# require "selenium/wxebdriver"


# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }
Dir[Rails.root.join("spec/page_objects/**/*.rb")].sort.each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  # Remove this line if you"re not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Capybara.register_driver :chrome do |app|
  #   Capybara::Selenium::Driver.new app, browser: :chrome,
  #                                  options:      Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
  # end

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument "headless"
    options.add_argument "no-sandbox"
    options.add_argument "disable-gpu"
    options.add_argument "disable-dev-shm-usage"
    Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
    )
  end

  Capybara.default_driver = :headless_chrome


  ## Headless!
=begin
  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new

    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--test-type')
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--disable-popup-blocking')
    options.add_argument('--disable-extensions')
    options.add_argument('--enable-automation')
    options.add_argument('--window-size=1920,1080')
    options.add_argument("--start-maximized")

    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    logging_prefs: { 'browser' => 'ALL' }
    )

    Capybara::Selenium::Driver.new app, browser: :headless_chrome, options: options, desired_capabilities: capabilities
  end
=end

  ## Capy Configuration Defaults
  Capybara.configure do |config|
    config.server                = :puma
    config.javascript_driver     = :headless_chrome
    config.default_max_wait_time = 7
  end

  config.include Warden::Test::Helpers, type: :feature
  config.after(type: :feature) { Warden.test_reset! }
  config.include WaitForAjax, type: :feature
end
