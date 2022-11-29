# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
    :address              => "smtp.mailtrap.io",
    :port                 => 25,
    :user_name            => "c3d5006fe4465b",
    :password             => '5a26e91542ff14',
    :authentication       => "PLAIN",
    :enable_starttls_auto => true
    }