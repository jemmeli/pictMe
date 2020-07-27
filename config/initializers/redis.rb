if Rails.env.staging? || Rails.env.production?
  #uri = URI.parse(ENV["REDIS_URL"])
  #uri = "http://127.0.0.1:6379/"
  #$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
  $redis = Redis.new(url: ENV["REDIS_URL"])
  #$redis.ping
end
