# frozen_string_literal: true

source "https://rubygems.org"
# ruby File.read('.ruby-version').strip
ruby RUBY_VERSION.to_s

gem "annotate"
gem "bootstrap-sass"
gem "simple_form"
gem "client_side_validations"
gem "client_side_validations-simple_form"
gem "cocoon"
gem "coffee-rails"
gem "devise"
gem "devise-i18n"
gem "execjs", require: true
gem "font-awesome-rails"
gem "haml"
gem "high_voltage"
gem "i18n-js"
gem "jbuilder"
gem "jquery-rails"
gem "parslet"
gem "pg"
gem "pundit"
gem "rails"
gem "reject_deeply_nested"
gem "sass-rails"
gem "sdoc", group: :doc
gem "sitemap_generator"
gem "sorted-activerecord"
gem "sprockets-rails", "2.3.3"
gem "therubyracer"
gem "titleize"
gem "trix-rails", require: "trix" # Rich text editor
gem "uglifier"
gem "webdrivers"
gem "webpack"

group :development, :test do
  gem "brakeman", require: false
  gem "byebug"
  gem "connection_pool"
  gem "launchy"
  gem "orderly"
  gem "poro-rails"
  gem "pry-byebug"
  gem "rails-controller-testing"
  gem "rb-readline"
  gem "rspec-rails"
  gem "simplecov"
  gem "simplecov-html"
  gem "simplecov-lcov"
  gem "site_prism"
  gem "standard"
end

group :development do
  gem 'awesome_print'
  gem "better_errors"
  gem "binding_of_caller"
  gem "bundler-audit"
  gem "erb2haml"
  gem "fasterer"
  gem "guard"
  gem 'guard-bundler', require: false
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'guard-migrate'
  gem "guard-rspec", require: false
  gem "i18n-tasks"
  gem "overcommit"
  gem "prettier"
  gem "rails_best_practices"
  gem "rails-erd"
  gem "reek"
  # gem 'rubocop'
  # gem 'rubocop-performance'
  # gem 'rubocop-rails'
  # gem 'rubocop-rspec'
  gem "web-console"
  gem 'xray-rails'
  gem "yard"
  gem "yard-junk"
end

group :test do
  gem "capybara"
  gem "capybara-selenium"
  gem "cucumber"
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "selenium-webdriver"
end

group :production do
  gem "newrelic_rpm"
  gem "puma"
end
