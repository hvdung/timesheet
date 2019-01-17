FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y nodejs mysql-client
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler -v 2.0.1
RUN BUNDLER_VERSION=2.0.1 bundle install
COPY . /myapp
