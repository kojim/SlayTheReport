# frozen_string_literal: true

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'aws-sdk'
require 'twitter'
require 'oauth'
require 'json'

also_reload "#{File.dirname(__FILE__)}/floor.rb"
also_reload "#{File.dirname(__FILE__)}/image.rb"
also_reload "#{File.dirname(__FILE__)}/connector.rb"
also_reload "#{File.dirname(__FILE__)}/connector_mock.rb"

require_relative './floor'
require_relative './connector'
require_relative './connector_local'
require_relative './connector_mock'

set :bind, '0.0.0.0'

ddb, $twitter_service =
  configure do
    use Rack::Session::Cookie

    case ENV['DB_MODE']
    when 'staging'
      [RunDataService.new('SlayTheReport-v3p'), TwitterService.new]
    when 'production'
      [RunDataService.new('SlayTheReport-v3p'), TwitterService.new]
    when 'local'
      [RunDataServiceLocal.new('SlayTheReport'), TwitterServiceMock.new]
    when 'standalone'
      [RunDataServiceMock.new, TwitterServiceMock.new]
    end
  end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
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
  erb :mypage
end

post '/mypage/newreport' do
  runfile = File.read(params[:runfile][:tempfile])
  twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  # TODO: runfileサイズ超過の例外対処
  # Todo: 重複登録の例外対処
  # Todo: Run.new でのパース失敗の例外対処
  ddb.put_item(twitter.user.screen_name, params[:runfile][:filename], runfile, Run.new(runfile))
  redirect '/mypage'
end

get '/mypage/edit/:run_id' do |run_id|
  @is_edit_mode = true
  twitter = $twitter_service.token_authenticate(session[:twitter_token], session[:twitter_secret])
  @runid = run_id
  @report = ddb.get_item(
    twitter.user.screen_name,
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
    floor_comments,
    key_cards,
    key_cards_pos,
    key_relics,
    key_relics_pos
  )

  redirect '/mypage'
end

get '/report/:player_id/:run_id' do |player_id, run_id|
  @player = player_id
  @runid = run_id
  @report = ddb.get_item(
    player_id,
    run_id
  )
  @raw_run_json = (h(JSON.pretty_generate(@run.raw_json)) if params[:raw])
  if @raw_run_json
    erb :report_rawjson
  else
    erb :report
  end
end

get '/debug' do
  erb :debug
end
get '/batch' do
  # db = Aws::DynamoDB::Client.new(region: 'ap-northeast-1')
  # resp = db.scan(
  #   table_name: 'SlayTheReport',
  # )
  # resp.items.map do |e|
  #   r = JSON.parse(e['report2'])
  #   run = Run.new(e['runfile'])
  #   db.put_item(
  #     table_name: 'SlayTheReport-v3p',
  #     item: {
  #       author: e['author'],
  #       runid: e['runid'],
  #       last_modified: run.raw_json['timestamp']*1000,
  #       runfile: e['runfile'],
  #       run_summary: JSON.generate({
  #         victory: run.victory,
  #         floor_reached: run.floor_reached,
  #         ascension_level: run.ascension_level,
  #         character_chosen: run.character_chosen
  #       }),
  #       report_summary: JSON.generate({
  #         title: r.fetch('title', e['runid'])
  #       }),
  #       report_body: JSON.generate({
  #         floor_comment: r.fetch('floor_comment', [])
  #       }),
  #       pseudo_pk: 'dummy'
  #     }
  #   )
  # end
end
