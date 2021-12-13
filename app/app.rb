# frozen_string_literal: true

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'aws-sdk'
require 'twitter'
require 'oauth'
require 'json'
require 'digest/md5'

also_reload "#{File.dirname(__FILE__)}/floor.rb"
also_reload "#{File.dirname(__FILE__)}/image.rb"
also_reload "#{File.dirname(__FILE__)}/connector.rb"
also_reload "#{File.dirname(__FILE__)}/connector_mock.rb"

require_relative './floor'
require_relative './connector'
require_relative './connector_mock'

$stdout.sync = true

ddb, ddb_author, $twitter_service, salt =
  case ENV['DB_MODE']
  when 'staging'
    [RunDataService.new(Aws::DynamoDB::Client.new(region: 'ap-northeast-1'), 'SlayTheReport-v3s'),
     AuthorDataService.new(Aws::DynamoDB::Client.new(region: 'ap-northeast-1'), 'SlayTheReport-author-v1s'),
     TwitterService.new,
     SaltService.salt]
  when 'production'
    [RunDataService.new(Aws::DynamoDB::Client.new(region: 'ap-northeast-1'), 'SlayTheReport-v3p'),
     AuthorDataService.new(Aws::DynamoDB::Client.new(region: 'ap-northeast-1'), 'SlayTheReport-author-v1p'),
     TwitterService.new,
     SaltService.salt]
  when 'local'
    [RunDataService.new([Aws::DynamoDB::Client.new(endpoint: 'http://dynamodb:8000', region: 'ap-northeast-1', access_key_id: 'fakeid', secret_access_key: 'fakekey'), 'SlayTheReport']),
     'dummy',
     TwitterServiceMock.new,
     'salt']
  when 'standalone'
    [RunDataServiceMock.new, 'dummy', TwitterServiceMock.new, 'salt']
  end

configure do
  use Rack::Session::Cookie
  set :bind, '0.0.0.0' if ENV['DB_MODE'] == 'local'
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
  def current(path)
    if request.path_info == path then
      "class='current'"
    else
      ''
    end
  end
end

def oauth
  key, secret = $twitter_service.get_api_keys
  OAuth::Consumer.new(
    key,
    secret,
    site: 'https://api.twitter.com',
    schema: :header,
    method: :post,
    request_token_path: '/oauth/request_token',
    access_token_path: '/oauth/access_token',
    authorize_path: '/oauth/authorize'
  )
end

get '/' do
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @reports = ddb.query_all
  @icons = ddb_author.query_all_icon()
  erb :index
end

get '/auth' do
  request_token = oauth.get_request_token(oauth_callback: "https://#{request.host}:#{request.port}/auth2")
  session[:token] = request_token.token
  session[:secret] = request_token.secret
  redirect request_token.authorize_url
end

get '/auth2' do
  request_token = OAuth::RequestToken.new(oauth, session[:token], session[:secret])
  access_token = oauth.get_access_token(request_token, oauth_verifier: params[:oauth_verifier])
  session[:twitter_token] = access_token.token
  session[:twitter_secret] = access_token.secret
  redirect '/'
end

get '/mypage' do
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @reports = ddb.query_by_author(@twitter.user.screen_name)
  @icons = ddb_author.query_all_icon()
  erb :mypage
end

post '/mypage/newreport' do
  # 30kb 以上のrunfileは無視する
  # Todo: 何かメッセージを出すべきである
  redirect '/mypage' unless File.basename(params[:runfile][:filename]).match(/^\d+.run$/)
  redirect '/mypage' if File.size(params[:runfile][:tempfile]) >= (30 * 1000)

  runfile = File.read(params[:runfile][:tempfile])
  twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  begin
    ddb.put_item(twitter.user.screen_name, params[:runfile][:filename], runfile, Run.new(runfile))
  rescue JSON::ParserError => ex
    # パースできないJSONは無視する
    # Todo: 何かメッセージを出すべきである
  rescue Aws::DynamoDB::Errors::ConditionalCheckFailedException => ex
    # 同一ファイルの重複登録は無視する
    # Todo: 何かメッセージを出すべきである
  end

  url= $twitter_service.get_icon_url(session[:twitter_token], session[:twitter_secret], twitter.user.screen_name)
  ddb_author.update_icon(twitter.user.screen_name, url)

  redirect '/mypage'
end

get '/mypage/edit/:run_id' do |run_id|
  @is_edit_mode = true
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @icons = ddb_author.query_all_icon()
  @runid = run_id
  @report = ddb.get_item(
    @twitter.user.screen_name,
    run_id
  )
  erb :report
end

post '/mypage/edit/:run_id' do |run_id|
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])

  floor_comments = params.keys.filter { |k| k.start_with?('report_') }.sort.map do |key|
    params[key]
  end

  key_cards = []
  key_cards_pos = []
  params.keys.filter { |k| k.start_with?('key_card_') }.each do |key|
    key_cards << params[key]
    key_cards_pos << key.gsub(/key_card_/, '')
  end

  key_relics = []
  key_relics_pos = []
  params.keys.filter { |k| k.start_with?('key_relic_') }.each do |key|
    key_relics << params[key]
    key_relics_pos << key.gsub(/key_relic_/, '')
  end

  ddb.update_item(
    @twitter.user.screen_name,
    run_id,
    params['title'],
    params['description'],
    floor_comments,
    key_cards,
    key_cards_pos,
    key_relics,
    key_relics_pos
  )

  redirect '/mypage'
end

post '/mypage/delete/:run_id' do |run_id|
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  ddb.delete_item(@twitter.user.screen_name, run_id)
  redirect '/mypage'
end

get '/anonymous' do
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @reports = ddb.query_by_author('anonymous')
  @icons = ddb_author.query_all_icon()
  erb :anonymous
end

get '/anonymous/auth/:run_id' do |run_id|
  # TODO: REST的に奇妙な設計。後で直すかも。
  report = ddb.get_item('anonymous', run_id)
  if report.password == Digest::MD5.hexdigest(params['password'] + salt) then
    status 200
    body 'OK'
  else
    status 401
    body 'Unauthorized'
  end
end

post '/anonymous/newreport' do
  # 30kb 以上のrunfileは無視する
  # Todo: 何かメッセージを出すべきである
  redirect '/anonymous' unless File.basename(params[:runfile][:filename]).match(/^\d+.run$/)
  redirect '/anonymous' if File.size(params[:runfile][:tempfile]) >= (30 * 1000)

  runfile = File.read(params[:runfile][:tempfile])
  begin
    ddb.put_item('anonymous', params[:runfile][:filename], runfile, Run.new(runfile), Digest::MD5.hexdigest(params['password'] + salt))
  rescue JSON::ParserError => ex
    # パースできないJSONは無視する
    # Todo: 何かメッセージを出すべきである
  rescue Aws::DynamoDB::Errors::ConditionalCheckFailedException => ex
    # 同一ファイルの重複登録は無視する
    # Todo: 何かメッセージを出すべきである
  end

  url= $twitter_service.get_icon_url(session[:twitter_token], session[:twitter_secret], 'anonymous')
  ddb_author.update_icon('anonymous', url)

  redirect '/anonymous'
end

get '/anonymous/edit/:run_id' do |run_id|
  @is_edit_mode = true
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @report = ddb.get_item(
    'anonymous',
    run_id
  )
  @icons = ddb_author.query_all_icon()
  redirect '/anonymous' unless @report.password == Digest::MD5.hexdigest(params['password'] + salt)
  erb :report
end

post '/anonymous/edit/:run_id' do |run_id|
  report = ddb.get_item(
    'anonymous',
    run_id
  )
  redirect '/anonymous' unless report.password == Digest::MD5.hexdigest(params['password'] + salt)

  floor_comments = params.keys.filter { |k| k.start_with?('report_') }.sort.map do |key|
    params[key]
  end

  key_cards = []
  key_cards_pos = []
  params.keys.filter { |k| k.start_with?('key_card_') }.each do |key|
    key_cards << params[key]
    key_cards_pos << key.gsub(/key_card_/, '')
  end

  key_relics = []
  key_relics_pos = []
  params.keys.filter { |k| k.start_with?('key_relic_') }.each do |key|
    key_relics << params[key]
    key_relics_pos << key.gsub(/key_relic_/, '')
  end

  ddb.update_item(
    'anonymous',
    run_id,
    params['title'],
    params['description'],
    floor_comments,
    key_cards,
    key_cards_pos,
    key_relics,
    key_relics_pos,
    Digest::MD5.hexdigest(params['password'] + salt)
  )

  redirect '/anonymous'
end

post '/anonymous/delete/:run_id' do |run_id|
  report = ddb.get_item(
    'anonymous',
    run_id
  )
  redirect '/anonymous' unless report.password == Digest::MD5.hexdigest(params['password'] + salt)
  ddb.delete_item('anonymous', run_id)
  redirect '/anonymous'
end

get '/report/:player_id/:run_id' do |player_id, run_id|
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @player = player_id
  @runid = run_id
  @report = ddb.get_item(
    player_id,
    run_id
  )
  @icons = ddb_author.query_all_icon()
  if params[:raw]
    erb :report_rawjson
  else
    erb :report
  end
end

get '/users' do
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  authors = ddb.query_authors
  @authors = authors.group_by{|e|e}
  erb :users
end

get '/users/:player_id' do |user|
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @author = user
  @reports = ddb.query_by_author(user)
  @icons = ddb_author.query_all_icon()
  erb :user
end

get '/help' do
  @twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  erb :help
end

get '/debug' do
  @text = 'debug'
  erb :debug
end
