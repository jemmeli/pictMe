# config/puma.rb
environment ENV['RACK_ENV'] || 'production'
threads ENV['MIN_PUMA_WORKERS_COUNT'],ENV['MAX_PUMA_WORKERS_COUNT']

workers 1
preload_app!

on_restart do
  $redis.reconnect
end
