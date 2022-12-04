#
# docker build -t iamteacher/sidekiq:web.arm64 -f Dockerfile --platform="linux/arm64" .
# docker build -t iamteacher/sidekiq:web.amd64 -f Dockerfile --platform="linux/amd64" .
#
# docker run -ti iamteacher/sidekiq:web.arm64 ash
# docker run -ti iamteacher/sidekiq:web.amd64 ash
FROM ruby:3.1-alpine

WORKDIR /sidekiq

RUN gem install rack-session -v 0.3.0
RUN gem install rackup -v 0.2.3
RUN gem install webrick -v 1.7.0
RUN gem install sidekiq -v 7.0.2

COPY config.ru .

CMD rackup config.ru -o 0.0.0.0 -p 3030 -q
