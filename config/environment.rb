require File.expand_path('../application', __FILE__)
Rails.application.initialize!

puts 'ENV'
puts ENV.to_h.to_yaml