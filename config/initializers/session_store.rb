# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379'

Rails.application.config.session_store :redis_session_store, {
  key: '_lambda_session',
  redis: {
    db: 2,
    expire_after: 120.minutes,
    key_prefix: 'lambda:session:',
    url: redis_url
  }
}
