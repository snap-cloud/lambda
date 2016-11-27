source 'https://rubygems.org'

ruby "2.3.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7'

# Use Puma as the app server
gem 'puma'

# Always use postgres as the db
gem 'pg'


# Frontend Utilities
# Use SCSS for stylesheets
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails' # Templates
gem 'gon' # JS Data Transfer
# https://github.com/rails/turbolinks
gem 'turbolinks'


# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc


# TODO: need this?
gem "flutie"
gem "high_voltage"
gem "newrelic_rpm", ">= 3.9.8"

gem "rack-canonical-host"

# User Accounts & LTI
gem 'dce_lti', path: './dce-lti/'
# Not using postgres due to Heroku's r/ow limit.
gem 'redis-session-store'
gem 'omniauth-google-oauth2'

# Temporary(?) Admin Dashboard-y Things
gem 'blazer' #, path: '../blazer/' # write and save queries
gem 'pghero' # Analyze DB performance.

# SPECIFIC APIS BECAUSE EDUC APIS ARE HELL
gem 'canvas-api'

group :development do
  gem "refills"
  gem "spring"
  gem "spring-commands-rspec"

  # Custtom Error Pages in Dev Only
  gem "better_errors"
  gem "binding_of_caller"

  # Disable logging Assets in the Server log
  gem 'quiet_assets'

  # Code Linting
  gem 'rubocop', require: false

  # Better Debugging From Rails Console (See Readme)
  gem 'awesome_print'

  # Code Quality Locally
  gem 'metric_fu'

  # Security Analysis
  gem 'brakeman'
  # DB Query Analysis / Optimizations
  gem "bullet"
end

group :development, :test do
  # Call 'debugger' anywhere in code to get a debugger console
  gem 'byebug'

  gem 'pry'

  gem "bundler-audit", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4.0"
end

group :test do
  # Note this requires qt on a mac
  # gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rails_stdout_logging"
  gem "rack-timeout"
  # For Heroku:
  gem "rails_12factor"
end
