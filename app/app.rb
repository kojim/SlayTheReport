# encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'aws-sdk'
require 'twitter'
require 'oauth'

also_reload File.dirname(__FILE__) + "/floor.rb"
also_reload File.dirname(__FILE__) + "/image.rb"
also_reload File.dirname(__FILE__) + "/keymanager.rb"

require_relative './floor'
require_relative './keymanager'

configure do
  use Rack::Session::Cookie
end
helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def oauth
  OAuth::Consumer.new(
    $Key['TwitterAPIKey'],
    $Key['TwitterAPIKeySecret'],
    :site => 'https://api.twitter.com',
    :schema => :header,
    :method => :post,
    :request_token_path => '/oauth/request_token',
    :access_token_path => '/oauth/access_token',
    :authorize_path => '/oauth/authorize'
  )
end
def twitter
  Twitter::REST::Client.new do |config|
    config.consumer_key = $Key['TwitterAPIKey']
    config.consumer_secret = $Key['TwitterAPIKeySecret']
    config.access_token = session[:twitter_token]
    config.access_token_secret = session[:twitter_secret]
  end
end
ddb = Aws::DynamoDB::Client.new(
    region: 'ap-northeast-1'
)

get '/' do
  @text = "hello anonymous user"

  if session[:twitter_token] != nil and session[:twitter_secret] != nil then
    @text = "hello #{twitter.user.name}/#{twitter.user.screen_name}"
  end

  resp = ddb.scan(
    table_name: 'SlayTheReport', 
  )
  @reports = resp.items.map {|e|
    Report.new(e['author'], e['runid'], JSON.parse(e['report2']))
  }
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
  resp = ddb.query(
    table_name: 'SlayTheReport', 
    key_condition_expression: 'author = :author',
    expression_attribute_values: { ':author' => twitter.user.screen_name },
  )
  @reports = resp.items.map {|e|
    Report.new(e['author'], e['runid'], JSON.parse(e['report2']))
  }
  erb :mypage
# @text = resp.items[0]['report2']
# erb :debug
end

post '/mypage/newreport' do
  @text = "hello text3"
  @text = File.read(params[:runfile][:tempfile])
  ddb.put_item(
    table_name: 'SlayTheReport',
    item:  {
      author: twitter.user.screen_name,
      runid:  params[:runfile][:filename],
      runfile: @text,
      report2: '{}'
    }
  )
  redirect '/mypage'
end

get '/mypage/edit/:run_id' do |run_id|
  @is_edit_mode = true
  @player = twitter.user.screen_name
  @runid = run_id
  result = ddb.get_item(
    table_name: 'SlayTheReport',
    key: {
      author: @player,
      runid: run_id
    }
  )
  @run = Run.new(result['item']['runfile'])
  @report = Report.new(result['item']['author'], result['item']['runid'], JSON.parse(result['item']['report2']))
  erb :report
end

post '/mypage/edit/:run_id' do |run_id|
  @player = twitter.user.screen_name
  reports = []
  params.keys.filter{|k| k.start_with?('report_')}.sort.each do |key|
    reports << params[key]
  end
  summary = {
    "title" => params['title']
  }
  ddb.update_item(
    table_name: 'SlayTheReport',
    key: {
      author: @player,
      runid: run_id
    },
    attribute_updates: {
      "report2" => {
        "value" => JSON.generate({
          "title" => params['title'],
          "floor_comment" => reports
        }),
        "action" => "PUT"
      },
    }
  )

  redirect '/mypage'
end

get '/report/:player_id/:run_id' do |player_id, run_id|
  @player = player_id
  @runid = run_id
  result = ddb.get_item(
    table_name: 'SlayTheReport',
    key: {
      author: player_id,
      runid: run_id
    }
  )
  @run = Run.new(result['item']['runfile'])
  @report = Report.new(result['item']['author'], result['item']['runid'], JSON.parse(result['item']['report2']))
  erb :report
  #@text = JSON.parse(result['item']['report'])
  #erb :debug
end


