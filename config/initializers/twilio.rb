# Twilio.configure do |config|
#   config.account_sid = ENV['twilio_account_sid']
#   config.auth_token = ENV['twilio_auth_token']
# end
Twilio.configure do |config|
  config.account_sid = ENV['twilio_sid']
  # p 'hello world'
  # p ENV['twilio_sid']
  # p ENV['twilio_auth_token']
  config.auth_token = ENV['twilio_auth_token']
end