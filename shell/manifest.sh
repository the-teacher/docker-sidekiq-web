# source shell/manifest.sh

docker manifest create \
  iamteacher/sidekiq \
  --amend iamteacher/sidekiq:web.arm64 \
  --amend iamteacher/sidekiq:web.amd64
