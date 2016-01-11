source 'https://rubygems.org'

ruby "2.3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Puma as the app server
gem 'puma'

gem "autoprefixer-rails"
gem "bourbon", "~> 4.2.0"
gem "delayed_job_active_record"
gem "flutie"
gem "high_voltage"
gem "neat", "~> 1.7.0"
# gem "newrelic_rpm", ">= 3.9.8"
gem "normalize-rails", "~> 3.0.0"

gem "rack-canonical-host"

# Emailing
# gem "recipient_interceptor"

gem "simple_form"
gem "title"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# LTI
gem 'ims-lti'

group :development do
  gem "quiet_assets"
  gem "refills"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'pry'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4.0"
end

group :test do
  gem "pg"
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "pg"
  gem "rails_stdout_logging"
  gem "rack-timeout"
end
