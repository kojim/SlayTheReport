# encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'aws-sdk'

# AWS.config(:credential_provider => AWS::Core::CredentialProviders::EC2Provider.new)
client = Aws::S3::Client.new( :region => 'ap-northeast-1')

get '/' do
  @text = "hello text3"
  erb :index
end

get '/mypage' do
  @text = "hello text3"
  erb :mypage
end

get '/mypage/edit/:runid' do
  @text = "hello text3"
  erb :edit
end

get '/view/:player_id/:runid' do
  @text = "hello text3"
  erb :view
end


