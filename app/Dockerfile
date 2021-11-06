FROM ruby:2.7-slim

WORKDIR app
RUN apt update
RUN apt install build-essential awscli -y

COPY ./* ./

RUN bundle install
CMD sh ./createtable.sh ; bundle exec ruby app.rb -p 80
