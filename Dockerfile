FROM ruby:3.0.3-alpine AS build-env

ENV RAILS_ROOT=/app
ENV BUILD_PACKAGES="build-base curl-dev git libc6-compat"
ENV DEV_PACKAGES="yaml-dev zlib-dev"
ENV RUBY_PACKAGES="tzdata"
ENV RAILS_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
ENV BUNDLE_PATH="$RAILS_ROOT/vendor/bundle"

WORKDIR $RAILS_ROOT

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

RUN gem install bundler:2.3.7

############### Production build ###############
FROM build-env AS ruby-app

ENV RAILS_ROOT=/app
COPY Gemfile Gemfile.lock $RAILS_ROOT/
RUN bundle config --global frozen 1
RUN bundle install --path $BUNDLE_PATH
RUN rm -rf $BUNDLE_PATH/ruby/3.0.0/cache/*.gem
RUN find $BUNDLE_PATH/ruby/3.0.0/gems/ -name "*.c" -delete
RUN find $BUNDLE_PATH/ruby/3.0.0/gems/ -name "*.o" -delete

COPY . .

# Remove folders not needed in resulting image
RUN rm -rf $RAILS_ROOT/tmp/cache $RAILS_ROOT/vendor/assets $RAILS_ROOT/spec

############### Build step done ###############
FROM ruby-app as final

ENV PACKAGES="tzdata bash libc6-compat"
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

COPY --from=ruby-app $RAILS_ROOT $RAILS_ROOT
WORKDIR $RAILS_ROOT

CMD '/app/bin/puma'
