Rails.application.configure do
  config.action_mailer.default_url_options = { host: "http://192.168.1.170", port: ENV['PORT'] }
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  # config.action_mailer.default_url_options = { host: DOMAIN_URL }
  config.action_mailer.raise_delivery_errors = true
  # change mail delevry to either :smtp, :sendmail, :file, :test, :letter_opener_web
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address: ENV['SMTP_ADDRESS'],
      port: ENV['SMTP_PORT'].to_i,
      domain: ENV['SMTP_DOMAIN'],
      user_name: ENV['SMTP_USERNAME'],
      password: ENV['SMTP_PASSWORD'],
      authentication: 'plain',
      enable_starttls_auto: true
  }
  # Specify what domain to use for mailer URLs
  config.action_mailer.default_url_options = {host: "localhost:3000"}

  # Print deprecation notices to the Rails logger.
  # config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  # config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  #configuration des loggers
  config.log_level = :debug
  Sidekiq::Logging.logger.level = Logger::DEBUG

  # WKHTMLTOIMAGE_PATH = '/Users/IBI/.rvm/gems/ruby-2.3.0/bin/wkhtmltoimage'
  WKHTMLTOIMAGE_PATH = '/usr/local/bin/wkhtmltoimage'
  PERFORM_SENDING = true

  Rails.application.config.active_job.queue_adapter = :sidekiq

  #parameter for HTTParty to check the authenticity of SSL certificate
  VERIFY_SSL = false
  # DOMAIN_URL = "https://kapp10-finishline.herokuapp.com"
  DOMAIN_URL = "http://localhost:3000"
  HOST = "localhost:3000"

  default_url_options[:host] = HOST 
end
