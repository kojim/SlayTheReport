# encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'aws-sdk'
require 'twitter'
require 'oauth'

also_reload File.dirname(__FILE__) + "/floor.rb"
also_reload File.dirname(__FILE__) + "/image.rb"
also_reload File.dirname(__FILE__) + "/connector.rb"
also_reload File.dirname(__FILE__) + "/connector_mock.rb"

require_relative './floor'
require_relative './connector'
require_relative './connector_mock'

$ddb = nil
$twitterService = nil
configure do
  use Rack::Session::Cookie

  if ENV['STR_STANDALONE'] != nil then
    $ddb = RunDataServiceMock.new
    $twitterService = TwitterServiceMock.new()
  else
    $ddb = RunDataService.new
    $twitterService = TwitterService.new()
  end

end
helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def oauth
  key, secret = $twitterService.get_api_keys
  OAuth::Consumer.new(
    key,
    secret,
    :site => 'https://api.twitter.com',
    :schema => :header,
    :method => :post,
    :request_token_path => '/oauth/request_token',
    :access_token_path => '/oauth/access_token',
    :authorize_path => '/oauth/authorize'
  )
end

get '/' do
  @twitter = $twitterService.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @reports = $ddb.query_all()
  erb :index
end

get '/auth' do
  request_token = oauth.get_request_token(:oauth_callback => "https://#{request.host}:#{request.port}/auth2")
  session[:token] = request_token.token
  session[:secret] = request_token.secret
  redirect request_token.authorize_url
end

get '/auth2' do
  request_token = OAuth::RequestToken.new(oauth, session[:token], session[:secret])
  access_token = oauth.get_access_token(request_token, :oauth_verifier => params[:oauth_verifier])
  session[:twitter_token] = access_token.token
  session[:twitter_secret] = access_token.secret
  redirect '/'
end

get '/mypage' do
  @twitter = $twitterService.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @reports = $ddb.query_by_author(
    @twitter.user.screen_name
  )
  erb :mypage
end

post '/mypage/newreport' do
  runfile = File.read(params[:runfile][:tempfile])
  twitter = $twitterService.token_authenticate(session[:twitter_token], session[:twitter_secret])
  $ddb.put_item(
    twitter.user.screen_name,
    params[:runfile][:filename],
    runfile
  )
  redirect '/mypage'
end

get '/mypage/edit/:run_id' do |run_id|
  @is_edit_mode = true
  twitter = $twitterService.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @runid = run_id
  @run, @report = $ddb.get_item(
    twitter.user.screen_name,
    run_id
  )
  erb :report
end

post '/mypage/edit/:run_id' do |run_id|
  @twitter = $twitterService.token_authenticate(session[:twitter_token], session[:twitter_secret])
  reports = []
  params.keys.filter{|k| k.start_with?('report_')}.sort.each do |key|
    reports << params[key]
  end
  $ddb.update_item(
    @twitter.user.screen_name,
    run_id,
    params['title'],
    reports
  )

  redirect '/mypage'
end

get '/report/:player_id/:run_id' do |player_id, run_id|
  @player = player_id
  @runid = run_id
  @run, @report = $ddb.get_item(
    player_id,
    run_id
  )
  erb :report
end

