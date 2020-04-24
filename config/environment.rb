# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Set the default host and port to be the same as Action Mailer.
Blacklight::Application.default_url_options = \
Blacklight::Application.config.action_mailer.default_url_options