require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL"), :namespace => ENV.fetch("REDIS_NAMESPACE", "sidekiq") }
end

require 'sidekiq/web'
run Sidekiq::Web
