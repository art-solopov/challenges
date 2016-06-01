FROM ruby:2.3

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
ENTRYPOINT ["/usr/bin/env", "ruby", "/app/app.rb", "-o", "0.0.0.0"]
