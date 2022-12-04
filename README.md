# Dockerized Sidekiq Web UI

### Why?

If you have an old Sidekiq, but want to use most recent version of Sidekiq Web UI.

### What Images?

- [ARM64](https://hub.docker.com/r/iamteacher/sidekiq/tags)
- [AMD64](https://hub.docker.com/r/iamteacher/sidekiq/tags)

### Dockerfile Repo

- https://github.com/the-teacher/docker-sidekiq-web

### Docker Hub page

- https://hub.docker.com/r/iamteacher/sidekiq

### Image contains

* Alpine
* Ruby 3
* Sidekiq 7.0.2
* HTTP Basic Auth support

# Usage

## Docker Compose

Run with `docker-compose -f docker-compose.yml up`

```yaml
version: '3.8'

services:
  redis:
    image: redis:7.0.5-alpine
    ports:
      - 6379:6379
    volumes:
      - db/REDIS:/data

  sidekiq_web:
    image: iamteacher/sidekiq:web.arm64
    environment:
      REDIS_URL: redis://redis:6379
      SIDEKIQ_USER: admin
      SIDEKIQ_PASSWORD: password123
    ports:
      - 3030:3030
```

Now Web UI is available on `http://localhost:3030`

### Simple Example

- Defailt value of `SIDEKIQ_USER` is `admin`
- Defailt value of `SIDEKIQ_PASSWORD` is `admin`

```javascript
docker run \
  -p 3030:3030 \
  -e REDIS_URL=redis://redis:6379 \
  -e SIDEKIQ_USER=admin \
  -e SIDEKIQ_PASSWORD=admin \
  iamteacher/sidekiq:web.arm64
```

### Important notes

- Sidekiq iteself must be run in a container with your application. This container provides only Web UI which can be started separately only by having an access to Redis.
- Sidekiq [does not support Redis Client Namespaces](https://github.com/mperham/sidekiq/blob/main/lib/sidekiq/redis_client_adapter.rb#L85) anymore. You should not use `namespace` option in your application.

```ruby
Sidekiq.configure_client do |config|
  config.redis = {
    url: redis_url,
    namespace: 'my-app-nmespace' # <<< must be removed
  }
end
```

### Original Solution

- https://hub.docker.com/r/aschzero/sidekiq-web

### License

- [MIT](https://opensource.org/licenses/MIT)
