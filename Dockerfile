FROM ubuntu:xenial

RUN apt-get update && apt-get install -y ruby
RUN gem install bundler && \
    bundle install && \
    bundle exec itamae local roles/home.rb
