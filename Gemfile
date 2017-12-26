source 'https://rubygems.org'

ruby "2.4.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'

# Use Puma as the app server
gem 'puma'

# Always use postgres as the db
gem 'pg', '0.20.0'

# Frontend Utilities
# Use SCSS for stylesheets
# TODO: Upgrade to v4
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
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc


# TODO: need this?
gem "flutie"
gem "high_voltage"

# User Accounts & LTI
gem 'oauth'
gem 'ims-lti', '< 2'
gem 'rack-plastic'
gem 'p3p'
# LTI data is stored in a session, and is too big for a cookie
gem 'redis-session-store'
gem 'omniauth-google-oauth2'

# Admin Dashboard-y Things
gem 'blazer' #, path: '../blazer/' # write and save queries
gem 'pghero' # Analyze DB performance.

# SPECIFIC APIS BECAUSE EDUC APIS ARE HELL
gem 'canvas-api'

# INVESTIGATE:
# Clientside validation for forms
# gem 'jquery-validation-rails'
# gem 'histogram'


group :development do
  gem 'annotate'

  gem 'foreman'
  # gem "refills"
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
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "pry-rails"

  gem 'jazz_fingers'

  # Generate fake user data.
  gem 'faker'

  # gem 'rspec'
  gem "rspec-rails", "~> 3.4.0"

  # Test / Code quality utils

end

group :test do
  gem "capybara"
  # Note this requires qt on a mac
  # gem "capybara-webkit"
  # gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  # gem "timecop"
  # gem "webmock"
end

group :staging, :production do
  gem "newrelic_rpm", ">= 3.9.8"

  gem "rails_stdout_logging"
  gem "rack-timeout"
  # For Heroku:
  gem "rails_12factor"
  # Redirects for Heroku
  gem "rack-canonical-host"
end
