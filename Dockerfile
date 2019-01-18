FROM ruby:2.5.1
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y build-essential libpq-dev zip curl nodejs mysql-client
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler -v 2.0.1
RUN BUNDLER_VERSION=2.0.1 bundle install
