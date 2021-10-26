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

get '/' do
  @text = "hello anonymous user"

  if session[:twitter_token] != nil and session[:twitter_secret] != nil then
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = $Key['TwitterAPIKey']
      config.consumer_secret = $Key['TwitterAPIKeySecret']
      config.access_token = session[:twitter_token]
      config.access_token_secret = session[:twitter_secret]
    end
    @text = "hello #{twitter_client.user.name}"
  end
  erb :index
end

get '/auth' do
  oauth = OAuth::Consumer.new(
            $Key['TwitterAPIKey'],
            $Key['TwitterAPIKeySecret'],
            :site => 'https://api.twitter.com',
            :schema => :header,
            :method => :post,
            :request_token_path => '/oauth/request_token',
            :access_token_path => '/oauth/access_token',
            :authorize_path => '/oauth/authorize'
          )
  request_token = oauth.get_request_token(:oauth_callback => "https://#{request.host}:#{request.port}/auth2")
  session[:token] = request_token.token
  session[:secret] = request_token.secret
  redirect request_token.authorize_url
end

get '/auth2' do
  oauth = OAuth::Consumer.new(
            $Key['TwitterAPIKey'],
            $Key['TwitterAPIKeySecret'],
            :site => 'https://api.twitter.com',
            :schema => :header,
            :method => :post,
            :request_token_path => '/oauth/request_token',
            :access_token_path => '/oauth/access_token',
            :authorize_path => '/oauth/authorize'
          )
  request_token = OAuth::RequestToken.new(oauth, session[:token], session[:secret])
  access_token = oauth.get_access_token(request_token, :oauth_verifier => params[:oauth_verifier])
  session[:twitter_token] = access_token.token
  session[:twitter_secret] = access_token.secret
  redirect '/'
end

get '/mypage' do
  @text = "hello text3"
  erb :mypage
end

get '/mypage/edit/:runid' do
  @text = "hello text3"
  erb :edit
end

get '/report/:player_id/:runid' do |player_id, run_id|
  @player = player_id
  @runid = run_id
  @text = '{"gold_per_floor":[116,116,116,41,61,86,86,119,174,189,230,251,91,109,109,215,287,316,188,197,296,171,196,196,213,213,248,265,265,265,293,293,404,404,415,415,415,415,265,265,295,316,352,373,429,441,453,490,502,514,526,547,96,129,129],"floor_reached":56,"playtime":2659,"items_purged":["Strike_R","Demon Form","Writhe","Bash","Sword Boomerang"],"score":1454,"play_id":"1fd2322a-ffc0-4bf9-b7ea-1f560e6178f6","local_time":"20211007184718","is_ascension_mode":true,"campfire_choices":[{"data":"Armaments","floor":7.0,"key":"SMITH"},{"data":"True Grit","floor":15.0,"key":"SMITH"},{"data":"Barricade","floor":24.0,"key":"SMITH"},{"data":"Corruption","floor":32,"key":"SMITH"},{"floor":40,"key":"RECALL"},{"floor":44,"key":"REST"},{"floor":49,"key":"REST"},{"floor":52,"key":"REST"}],"neow_cost":"TEN_PERCENT_HP_LOSS","seed_source_timestamp":1867471690376400,"circlet_count":0,"master_deck":["Immolate","Wild Strike","Armaments+1","Exhume+1","Battle Trance","Fire Breathing","True Grit+1","Power Through","Feel No Pain","Second Wind","Barricade+1","Ghostly Armor","Body Slam","Corruption+1","Rupture","Exhume","Seeing Red","Fire Breathing+1","Power Through","Impervious+1","Impervious","Master of Strategy","Pommel Strike+1","Evolve+1","Dark Embrace+1","Disarm+1","Shrug It Off"],"special_seed":0,"relics":["Burning Blood","Ancient Tea Set","Bag of Preparation","Self Forming Clay","Pen Nib","CeramicFish","Pandora\u0027s Box","Calipers","Regal Pillow","Ornamental Fan","Nilry\u0027s Codex","Incense Burner","Dream Catcher","Fusion Hammer","MawBank","PreservedInsect","War Paint","Mummified Hand","HornCleat"],"potions_floor_usage":[55,55],"damage_taken":[{"damage":0.0,"enemies":"2 Louse","floor":1.0,"turns":1.0},{"damage":11.0,"enemies":"Jaw Worm","floor":5.0,"turns":2.0},{"damage":20.0,"enemies":"Gremlin Nob","floor":6.0,"turns":4.0},{"damage":36.0,"enemies":"Lagavulin","floor":8.0,"turns":6.0},{"damage":3.0,"enemies":"Small Slimes","floor":10.0,"turns":2.0},{"damage":8.0,"enemies":"3 Sentries","floor":11.0,"turns":3.0},{"damage":6.0,"enemies":"3 Louse","floor":12.0,"turns":3.0},{"damage":0.0,"enemies":"Looter","floor":14.0,"turns":4.0},{"damage":7.0,"enemies":"Slime Boss","floor":16.0,"turns":8.0},{"damage":0.0,"enemies":"Spheric Guardian","floor":18.0,"turns":5.0},{"damage":8.0,"enemies":"Gremlin Leader","floor":23.0,"turns":8.0},{"damage":0.0,"enemies":"Shell Parasite","floor":25.0,"turns":5.0},{"damage":5,"enemies":"Slavers","floor":27,"turns":2},{"damage":0,"enemies":"Centurion and Healer","floor":28,"turns":6},{"damage":18,"enemies":"Book of Stabbing","floor":31,"turns":6},{"damage":1,"enemies":"Champ","floor":33,"turns":7},{"damage":0,"enemies":"3 Shapes","floor":35,"turns":4},{"damage":0,"enemies":"Nemesis","floor":41,"turns":7},{"damage":2,"enemies":"Giant Head","floor":45,"turns":5},{"damage":0,"enemies":"3 Darklings","floor":48,"turns":4},{"damage":0,"enemies":"Donu and Deca","floor":50,"turns":5},{"damage":0,"enemies":"Shield and Spear","floor":54,"turns":4},{"damage":4,"enemies":"The Heart","floor":55,"turns":5}],"seed_played":"-3363429452019887060","potions_obtained":[{"floor":1.0,"key":"ColorlessPotion"},{"floor":10.0,"key":"Energy Potion"},{"floor":11.0,"key":"Fire Potion"},{"floor":12.0,"key":"LiquidBronze"},{"floor":18.0,"key":"Strength Potion"},{"floor":48,"key":"Ancient Potion"},{"floor":54,"key":"SpeedPotion"}],"is_trial":false,"path_per_floor":["M","?","T","$","M","E","R","E","T","M","E","M","$","M","R","B",null,"M","$","?","?","$","E","R","M","T","E","M","?","T","E","R","B",null,"M","$","$","?","$","R","E","?","T","R","E","?","?","M","R","B",null,"R","$","E","B",null],"character_chosen":"IRONCLAD","items_purchased":["Fire Breathing","Feel No Pain","Second Wind","Power Through","Mummified Hand","Shrug It Off"],"campfire_rested":3,"item_purchase_floors":[4,13,13,19,53,53],"current_hp_per_floor":[72,72,72,72,67,53,53,23,23,26,24,24,24,30,30,29,72,72,72,72,72,72,70,70,72,72,72,72,56,56,44,44,49,72,72,72,72,68,68,68,68,58,58,68,68,68,68,68,68,68,68,68,68,68,68],"gold":129,"neow_bonus":"THREE_RARE_CARDS","is_prod":false,"is_daily":false,"chose_seed":false,"campfire_upgraded":4,"win_rate":0,"timestamp":1633600038,"path_taken":["M","?","?","$","M","E","R","E","T","M","E","M","$","M","R","BOSS","M","$","?","?","$","E","R","M","T","E","M","?","?","E","R","BOSS","M","?","$","?","$","R","E","?","T","R","E","?","?","M","R","BOSS","R","$","E","BOSS"],"build_version":"2020-12-22","purchased_purges":5,"victory":true,"max_hp_per_floor":[72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,72,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68],"card_choices":[{"not_picked":["Demon Form","Juggernaut"],"picked":"Immolate","floor":0.0},{"not_picked":["Heavy Blade","Twin Strike"],"picked":"Wild Strike","floor":1.0},{"not_picked":["Warcry","Metallicize"],"picked":"Armaments","floor":5.0},{"not_picked":["Perfected Strike","True Grit"],"picked":"Exhume","floor":6.0},{"not_picked":["Warcry","Sword Boomerang"],"picked":"Battle Trance","floor":8.0},{"not_picked":["Twin Strike","Iron Wave"],"picked":"Fire Breathing","floor":10.0},{"not_picked":["Sever Soul","Bloodletting"],"picked":"True Grit","floor":11.0},{"not_picked":["Fire Breathing","Shockwave"],"picked":"Power Through","floor":12.0},{"not_picked":["Entrench","Twin Strike","Cleave"],"picked":"SKIP","floor":14.0},{"not_picked":["Bludgeon","Immolate"],"picked":"Barricade","floor":16.0},{"not_picked":["Twin Strike","Body Slam+1"],"picked":"Fire Breathing+1","floor":18.0},{"not_picked":["Sentinel","Wild Strike+1","Hemokinesis"],"picked":"SKIP","floor":23.0},{"not_picked":["Wild Strike+1","Twin Strike","Rupture"],"picked":"SKIP","floor":25.0},{"not_picked":["Anger+1","Warcry"],"picked":"Impervious","floor":27},{"not_picked":["Uppercut","Perfected Strike","Iron Wave"],"picked":"SKIP","floor":28},{"not_picked":["Body Slam+1","Battle Trance","Pommel Strike+1"],"picked":"SKIP","floor":31},{"not_picked":["Juggernaut","Feed"],"picked":"Impervious","floor":33},{"not_picked":["Anger+1","Iron Wave","Disarm+1"],"picked":"SKIP","floor":35},{"not_picked":["Sever Soul+1","Headbutt","Dual Wield"],"picked":"SKIP","floor":41},{"not_picked":["Thinking Ahead","Jack Of All Trades"],"picked":"Master of Strategy","floor":42},{"not_picked":["Body Slam","Dual Wield+1"],"picked":"Pommel Strike+1","floor":44},{"not_picked":["Infernal Blade+1","Havoc+1"],"picked":"Evolve+1","floor":45},{"not_picked":["Dual Wield+1","Twin Strike"],"picked":"Dark Embrace+1","floor":48},{"not_picked":["Dropkick+1","Hemokinesis+1"],"picked":"Disarm+1","floor":52},{"not_picked":["Sword Boomerang","True Grit+1","Hemokinesis"],"picked":"SKIP","floor":54}],"player_experience":3481887,"relics_obtained":[{"floor":3.0,"key":"Ancient Tea Set"},{"floor":6.0,"key":"Bag of Preparation"},{"floor":8.0,"key":"Self Forming Clay"},{"floor":9.0,"key":"Pen Nib"},{"floor":11.0,"key":"CeramicFish"},{"floor":23.0,"key":"Regal Pillow"},{"floor":27,"key":"Ornamental Fan"},{"floor":29,"key":"Nilry\u0027s Codex"},{"floor":30,"key":"Incense Burner"},{"floor":31,"key":"Dream Catcher"},{"floor":41,"key":"MawBank"},{"floor":43,"key":"PreservedInsect"},{"floor":45,"key":"War Paint"},{"floor":54,"key":"HornCleat"}],"event_choices":[{"damage_healed":0.0,"max_hp_gain":0.0,"max_hp_loss":0.0,"gold_gain":0.0,"event_name":"Liars Game","player_choice":"Ignored","floor":2.0,"gold_loss":0.0,"damage_taken":0.0},{"damage_healed":0.0,"max_hp_gain":0.0,"max_hp_loss":0.0,"gold_gain":0.0,"event_name":"The Mausoleum","player_choice":"Opened","floor":20.0,"gold_loss":0.0,"damage_taken":0.0,"relics_obtained":["Calipers"],"cards_obtained":["Writhe"]},{"damage_healed":0.0,"max_hp_gain":0.0,"max_hp_loss":0.0,"gold_gain":99.0,"event_name":"Nest","player_choice":"Stole From Cult","floor":21.0,"gold_loss":0.0,"damage_taken":0.0},{"damage_healed":0,"gold_gain":0,"player_choice":"Obtained Book","damage_taken":16,"max_hp_gain":0,"max_hp_loss":0,"event_name":"Cursed Tome","floor":29,"gold_loss":0},{"damage_healed":0,"gold_gain":0,"player_choice":"Max HP","damage_taken":0,"max_hp_gain":0,"max_hp_loss":4,"event_name":"Winding Halls","floor":38,"gold_loss":0},{"damage_healed":0,"gold_gain":0,"player_choice":"Memory 3","damage_taken":10,"max_hp_gain":0,"max_hp_loss":0,"event_name":"SensoryStone","floor":42,"gold_loss":0},{"cards_removed":["Fire Breathing"],"damage_healed":0,"gold_gain":0,"player_choice":"Removed Power","damage_taken":0,"max_hp_gain":0,"max_hp_loss":0,"event_name":"Falling","floor":46,"gold_loss":0},{"damage_healed":0,"gold_gain":0,"player_choice":"0 cards matched","damage_taken":0,"max_hp_gain":0,"max_hp_loss":0,"event_name":"Match and Keep!","floor":47,"gold_loss":0,"cards_obtained":[]}],"is_beta":false,"boss_relics":[{"not_picked":["Snecko Eye","Astrolabe"],"picked":"Pandora\u0027s Box"},{"not_picked":["Empty Cage","Black Blood"],"picked":"Fusion Hammer"}],"items_purged_floors":[13,19,22,39,53],"is_endless":false,"potions_floor_spawned":[1,10,11,12,18,25,27,31,35,41,48,54],"ascension_level":1}'
  @run = Run.generate_from_json(@text)
  erb :report
end


