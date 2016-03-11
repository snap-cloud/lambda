# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_lambda_session'

# LTI Keys
Rails.application.config.session_store :active_record_store, key: '_lambda_ar_store', expire_after: 120.minutes