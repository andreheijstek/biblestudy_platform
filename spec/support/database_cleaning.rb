# frozen_string_literal: true

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    raise(<<-MSG) if config.use_transactional_fixtures?
        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
        (or set it to false) to prevent uncommitted transactions being used in
        JavaScript-dependent specs.

        During testing, the app-under-test that the browser driver connects to
        uses a different database connection to the database connection used by
        the spec. The app's database connection would not be able to access
        uncommitted transaction data setup over the spec's database connection.
    MSG

    DatabaseCleaner.clean_with(:truncation)
  end

  config.before { DatabaseCleaner.strategy = :transaction }

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    # noinspection RubyLocalVariableNamingConvention
    driver_shares_db_connection_with_specs =
      Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before do
    # noinspection RubyArgCount
    DatabaseCleaner.start
  end

  config.append_after { DatabaseCleaner.clean }
end
#
# RSpec.configure do |config|
#   config.before(:suite) do
#     DatabaseCleaner.strategy = :deletion
#     DatabaseCleaner.clean_with(:deletion)
#   end
#   config.before(:each) do
#     DatabaseCleaner.start
#   end
#   config.after(:each) do
#     DatabaseCleaner.clean
#   end
# end
