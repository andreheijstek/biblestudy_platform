# frozen_string_literal: true

# Load the Rails application.
require File.expand_path('application', __dir__)

# Initialize the Rails application.
Rails.application.initialize!

# Setup logging
Rails.logger = Logger.new($stderr)
Rails.application.configure do
  config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
end
Rails.logger.level = Logger::ERROR
Rails.logger.datetime_format = '%Y-%m-%d %H:%M:%S'
