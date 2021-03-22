FROM ruby:2.7.0 as development
RUN apt-get update -qq && apt-get install -y locales
RUN echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen ru_RU.UTF-8 && \
  /usr/sbin/update-locale LANG=ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

ENV APP_PATH=/usr/src
WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/
RUN bundle install

COPY . .

EXPOSE 4000
CMD ["rails", "server", "-b", "0.0.0.0"]


FROM development as production
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
COPY . .
RUN rails assets:precompile
CMD puma -t 3:5 -w 2 -b tcp://0.0.0.0:4000
