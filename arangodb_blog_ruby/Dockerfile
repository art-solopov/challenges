FROM ruby:2.3

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
ENTRYPOINT ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "4567"]
