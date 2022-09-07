FROM ruby:3.1.2-alpine

ENV BUNDLER_VERSION=2.3.1

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      mariadb-dev \
      python3 \
      tzdata \
      yarn

ENV RAILS_ROOT /var/www/

RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

RUN gem install bundler -v 2.3.1

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle check || bundle install

COPY package.json yarn.lock ./

RUN yarn install --check-files

COPY . ./

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]