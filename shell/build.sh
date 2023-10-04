# source shell/build.sh

docker build \
  -t iamteacher/sidekiq:web.arm64 \
  -f Dockerfile \
  --build-arg BUILDPLATFORM="linux/arm64" \
  --build-arg TARGETARCH="arm64" \
  .

docker build \
  -t iamteacher/sidekiq:web.amd64 \
  -f Dockerfile \
  --build-arg BUILDPLATFORM="linux/amd64" \
  --build-arg TARGETARCH="amd64" \
  .
