# encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @text = "hello text3"
  erb :index
end

