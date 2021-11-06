#!/bin/sh

bundle install

# export DB_MODE=local # iranai?
bundle exec ruby app.rb -o 0.0.0.0 -p 80
