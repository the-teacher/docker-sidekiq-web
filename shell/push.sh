# source shell/push.sh

docker push iamteacher/sidekiq:web.arm64
docker push iamteacher/sidekiq:web.amd64
docker manifest push --purge iamteacher/sidekiq:latest
