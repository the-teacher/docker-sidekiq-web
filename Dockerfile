# docker run -ti iamteacher/sidekiq:web.arm64 ash
# docker run -ti iamteacher/sidekiq:web.amd64 ash
FROM --platform=$BUILDPLATFORM ruby:3.2-alpine

ARG TARGETARCH
ARG BUILDPLATFORM

RUN echo "$BUILDPLATFORM" > /BUILDPLATFORM
RUN echo "$TARGETARCH" > /TARGETARCH

WORKDIR /sidekiq

RUN gem install rack-session -v 0.3.0
RUN gem install rackup -v 0.2.3
RUN gem install webrick -v 1.8.1
RUN gem install sidekiq -v 7.1.5

COPY config.ru .

CMD rackup config.ru -o 0.0.0.0 -p 3030 -q
