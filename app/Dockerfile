FROM ruby:2.7-slim

WORKDIR app
RUN apt update
RUN apt install build-essential -y

COPY ./* ./

RUN bundle install
CMD bundle exec ruby app.rb -p 80
