# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
ReserveMe::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'sendgrid_username',
  :password => 'sendgrid_password',
  :domain => 'yourdomain.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
