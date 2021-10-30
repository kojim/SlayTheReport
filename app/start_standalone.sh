#!/bin/sh

bundle install

export STR_STANDALONE=true
bundle exec ruby app.rb -o 0.0.0.0 -p 80

