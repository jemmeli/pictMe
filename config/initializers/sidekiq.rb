require 'sidekiq/scheduler'

Sidekiq.configure_server do |config|
  config.redis = {url: ENV['REDIS_URL']}
  config.average_scheduled_poll_interval = 5
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.join(Rails.root, 'config', 'scheduler.yml')) || {}
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV['REDIS_URL']}
end
