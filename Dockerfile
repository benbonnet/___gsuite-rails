FROM ruby:3.0.3-alpine AS build-env

ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base curl-dev git libc6-compat"
ARG DEV_PACKAGES="postgresql-dev postgresql-client yaml-dev zlib-dev"
ARG RUBY_PACKAGES="tzdata"
ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

# install packages
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

RUN gem install bundler:2.3.7

############### Production build ###############
FROM build-env AS ruby-app

COPY Gemfile Gemfile.lock $RAILS_ROOT/
RUN bundle config --global frozen 1
RUN bundle config set --local path 'vendor/bundle'
RUN bundle config set --local without 'development:test:assets'
RUN bundle install
RUN ls vendor/bundle/ruby/
RUN rm -rf vendor/bundle/ruby/3.0.0/cache/*.gem
RUN find vendor/bundle/ruby/3.0.0/gems/ -name "*.c" -delete
RUN find vendor/bundle/ruby/3.0.0/gems/ -name "*.o" -delete

COPY . .

RUN SECRET_KEY_BASE=xyz \
    DATABASE_URL=postgresql:does_not_exist \
    RAILS_ENV=production bin/rails assets:precompile

# Remove folders not needed in resulting image
RUN rm -rf tmp/cache vendor/assets spec

############### Build step done ###############
FROM ruby-app as final

ARG RAILS_ROOT=/app
ARG PACKAGES="postgresql-dev postgresql-client tzdata bash libc6-compat"
ENV RAILS_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

WORKDIR $RAILS_ROOT

# install packages
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

COPY --from=ruby-app $RAILS_ROOT $RAILS_ROOT

ENTRYPOINT ["./entrypoint.sh"]
