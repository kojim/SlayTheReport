#!/bin/sh

bundle install
bundle exec ruby app.rb -o 0.0.0.0 -p 80

