# Twilio.configure do |config|
#   config.account_sid = ENV['twilio_account_sid']
#   config.auth_token = ENV['twilio_auth_token']
# end
Twilio.configure do |config|
  config.account_sid = Rails.application.secrets.twilio_account_sid
  config.auth_token = Rails.application.secrets.twilio_auth_token
end