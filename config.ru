require 'sidekiq'
require 'sidekiq/web'
require 'rack/session'
require 'securerandom'

# Create secret
File.open(".session.key", "w") {|f| f.write(SecureRandom.hex(32)) }

sidekiq_user = ENV.fetch('SIDEKIQ_USER') { 'admin' }
sidekiq_password = ENV.fetch('SIDEKIQ_PASSWORD') { 'admin' }
redis_url = ENV.fetch('REDIS_URL') { 'redis://127.0.0.1:6379/0' }

Sidekiq.configure_client do |config|
  config.redis = {
    url: redis_url
  }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [sidekiq_user, sidekiq_password]
end

# Now use the secret with a session cookie middleware
use Rack::Session::Cookie,
  secret: File.read(".session.key"),
  same_site: true,
  max_age: 86400

run Sidekiq::Web
