# encoding: utf-8

require 'json'
require_relative './floor'

class RunDataServiceMock

  def initialize()
  end

  def query_all()
    $reports
  end

  def query_by_author(name)
    $reports
  end

  def get_item(author, runid)
    return Run.new($runfiles[0]), $reports[0]
  end

  def put_item(author, runid, runfile)
  end

  def update_item(author, runid, title, floor_comment)
  end
end

class TwitterClientMock
  def user
    TwitterUserMock.new
  end
end
class TwitterUserMock
  def name
    'dummy_name'
  end
  def screen_name
    'screen_name'
  end
end
class TwitterServiceMock
  def initialize()
  end
  def token_authenticate(token, secret)
    TwitterClientMock.new
  end
end


$reports = [
  Report.new('dummy_author', 'dummy_runid', {
    'title' => 'dummy_title',
    'floor_comments' => [
      'hello neow',
      '1st floor',
      '2nd floor',
    ]
  })
]
$runfiles = [
  '{"gold_per_floor":[19,36,52,72,90,117,117,5,30,30,30,30,44,79,79,210,273,297,320,220,243,263,296,316,316,342,221,241,241,340,340,340,466,466,485,503,503,516,531,565,565,601,653,674,695,739,752,397,397,397,397,397,193,231,231],"floor_reached":56,"playtime":3410,"items_purged":["Strike_R","Strike_R","Strike_R","Bash","Cleave"],"score":1298,"play_id":"ae276938-3b97-4219-974b-bdd7abf47e12","local_time":"20210912175740","is_ascension_mode":false,"campfire_choices":[{"data":"True Grit","floor":7.0,"key":"SMITH"},{"data":"Rampage","floor":12.0,"key":"SMITH"},{"data":"Uppercut","floor":15.0,"key":"SMITH"},{"data":"Shockwave","floor":25.0,"key":"SMITH"},{"data":"Evolve","floor":29.0,"key":"SMITH"},{"data":"Demon Form","floor":32.0,"key":"SMITH"},{"data":"Limit Break","floor":41.0,"key":"SMITH"},{"floor":49,"key":"RECALL"},{"data":"Barricade","floor":52,"key":"SMITH"}],"neow_cost":"NO_GOLD","seed_source_timestamp":2731759416013400,"circlet_count":0,"master_deck":["Defend_R","Defend_R","Defend_R","Defend_R","Iron Wave+1","Disarm","Shockwave+1","Rampage+1","True Grit+1","Inflame","Whirlwind","Uppercut+1","Impervious","Evolve+1","Ghostly Armor","Burning Pact","Demon Form+1","Feel No Pain","Impervious","Limit Break+1","Flame Barrier+1","Reaper","Dropkick","Offering","Barricade+1","Dual Wield","Offering"],"special_seed":0,"relics":["Burning Blood","Akabeko","PreservedInsect","Golden Idol","Bag of Marbles","Bag of Preparation","Tiny House","Singing Bowl","Smiling Mask","Velvet Choker","Vajra","Regal Pillow","Oddly Smooth Stone","Lantern","Strange Spoon","Calipers"],"potions_floor_usage":[55,55],"damage_taken":[{"damage":1.0,"enemies":"Cultist","floor":1.0,"turns":3.0},{"damage":0.0,"enemies":"2 Louse","floor":2.0,"turns":2.0},{"damage":1.0,"enemies":"Jaw Worm","floor":3.0,"turns":3.0},{"damage":7.0,"enemies":"3 Louse","floor":4.0,"turns":3.0},{"damage":5.0,"enemies":"Exordium Thugs","floor":5.0,"turns":4.0},{"damage":23.0,"enemies":"Lagavulin","floor":6.0,"turns":7.0},{"damage":1.0,"enemies":"Looter","floor":13.0,"turns":2.0},{"damage":2.0,"enemies":"Gremlin Nob","floor":14.0,"turns":4.0},{"damage":10.0,"enemies":"The Guardian","floor":16.0,"turns":9.0},{"damage":0.0,"enemies":"Chosen","floor":18.0,"turns":4.0},{"damage":9.0,"enemies":"Shell Parasite","floor":19.0,"turns":9.0},{"damage":3.0,"enemies":"Snecko","floor":21.0,"turns":6.0},{"damage":31.0,"enemies":"Sentry and Sphere","floor":22.0,"turns":7.0},{"damage":6.0,"enemies":"Gremlin Leader","floor":23.0,"turns":8.0},{"damage":19.0,"enemies":"Shelled Parasite and Fungi","floor":24.0,"turns":8.0},{"damage":13.0,"enemies":"Chosen and Byrds","floor":28.0,"turns":4.0},{"damage":8.0,"enemies":"Champ","floor":33.0,"turns":13.0},{"damage":18.0,"enemies":"3 Shapes","floor":35.0,"turns":4.0},{"damage":0.0,"enemies":"3 Darklings","floor":36.0,"turns":1.0},{"damage":0.0,"enemies":"Jaw Worm Horde","floor":38.0,"turns":1.0},{"damage":38.0,"enemies":"Sphere and 2 Shapes","floor":39.0,"turns":6.0},{"damage":26.0,"enemies":"Giant Head","floor":40.0,"turns":9.0},{"damage":12.0,"enemies":"Nemesis","floor":42.0,"turns":5.0},{"damage":0.0,"enemies":"Spire Growth","floor":44.0,"turns":4.0},{"damage":43.0,"enemies":"4 Shapes","floor":45.0,"turns":8.0},{"damage":11.0,"enemies":"Reptomancer","floor":46.0,"turns":6.0},{"damage":0,"enemies":"3 Darklings","floor":47,"turns":1},{"damage":56,"enemies":"Time Eater","floor":50,"turns":9},{"damage":65,"enemies":"Shield and Spear","floor":54,"turns":8},{"damage":66,"enemies":"The Heart","floor":55,"turns":10}],"seed_played":"-7346716603134146792","potions_obtained":[{"floor":3.0,"key":"Strength Potion"},{"floor":4.0,"key":"SkillPotion"},{"floor":6.0,"key":"Strength Potion"},{"floor":14.0,"key":"Regen Potion"},{"floor":16.0,"key":"Fire Potion"},{"floor":17.0,"key":"HeartOfIron"},{"floor":19.0,"key":"Block Potion"},{"floor":24.0,"key":"ColorlessPotion"},{"floor":42.0,"key":"DistilledChaos"}],"is_trial":false,"path_per_floor":["M","M","M","M","M","E","R","$","T","?","?","R","M","E","R","B",null,"M","M","$","M","M","E","M","R","T","$","M","R","?","?","R","B",null,"M","M","?","M","M","E","R","E","T","M","M","E","M","$","R","B",null,"R","$","E","B",null],"character_chosen":"IRONCLAD","items_purchased":["Inflame","Feel No Pain","Lantern","Offering","Strange Spoon"],"campfire_rested":0,"item_purchase_floors":[8,27,48,48,53],"current_hp_per_floor":[80,80,80,79,80,63,63,63,63,43,43,43,48,52,52,48,85,85,82,82,85,60,60,49,49,49,49,44,44,44,44,44,42,89,77,85,85,91,59,85,85,79,79,87,97,97,99,99,99,91,99,99,99,101,41],"gold":231,"neow_bonus":"TRANSFORM_TWO_CARDS","is_prod":false,"is_daily":false,"chose_seed":false,"campfire_upgraded":8,"win_rate":0,"timestamp":1631437060,"path_taken":["M","?","M","M","M","E","R","$","T","?","?","R","M","E","R","BOSS","M","M","$","M","M","E","M","R","T","$","?","R","?","?","R","BOSS","M","M","?","M","M","E","R","E","T","M","M","E","M","$","R","BOSS","R","$","E","BOSS"],"build_version":"2020-12-22","purchased_purges":5,"victory":true,"max_hp_per_floor":[80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,85,85,85,85,85,85,85,87,87,87,87,89,89,89,89,89,89,89,89,91,91,91,91,93,93,93,93,95,97,97,99,99,99,99,99,99,99,101,101],"card_choices":[{"not_picked":["Perfected Strike","Warcry","Infernal Blade"],"picked":"SKIP","floor":1.0},{"not_picked":["Anger","Infernal Blade","Hemokinesis"],"picked":"SKIP","floor":2.0},{"not_picked":["Cleave","Spot Weakness"],"picked":"Disarm","floor":3.0},{"not_picked":["Pommel Strike","Hemokinesis"],"picked":"Shockwave","floor":4.0},{"not_picked":["True Grit","Anger"],"picked":"Rampage","floor":5.0},{"not_picked":["Sword Boomerang","Sever Soul"],"picked":"True Grit","floor":6.0},{"not_picked":["Body Slam","Rampage"],"picked":"Whirlwind","floor":13.0},{"not_picked":["Armaments","Shockwave"],"picked":"Uppercut","floor":14.0},{"not_picked":["Double Tap","Barricade"],"picked":"Impervious","floor":16.0},{"not_picked":["Perfected Strike","Clash"],"picked":"Evolve","floor":17.0},{"not_picked":["Clash","Rampage+1"],"picked":"Ghostly Armor","floor":18.0},{"not_picked":["Thunderclap","Searing Blow+1","Hemokinesis"],"picked":"SKIP","floor":19.0},{"not_picked":["Thunderclap","Searing Blow+1","Hemokinesis"],"picked":"SKIP","floor":19.0},{"not_picked":["Flex","Cleave"],"picked":"Burning Pact","floor":21.0},{"not_picked":["Headbutt","Whirlwind+1","Iron Wave+1"],"picked":"SKIP","floor":22.0},{"not_picked":["Entrench","Armaments"],"picked":"Demon Form","floor":23.0},{"not_picked":["Heavy Blade","Armaments","Intimidate"],"picked":"Singing Bowl","floor":24.0},{"not_picked":["Flex","Wild Strike","Havoc"],"picked":"Singing Bowl","floor":28.0},{"not_picked":["Double Tap","Impervious"],"picked":"Limit Break","floor":33.0},{"not_picked":["Havoc+1","Pommel Strike"],"picked":"Flame Barrier+1","floor":35.0},{"not_picked":["Clothesline+1","True Grit+1","Headbutt+1"],"picked":"Singing Bowl","floor":36.0},{"not_picked":["Iron Wave","Intimidate"],"picked":"Dropkick","floor":38.0},{"not_picked":["Sword Boomerang+1","Perfected Strike+1"],"picked":"Offering","floor":39.0},{"not_picked":["Searing Blow","Cleave+1","Flex+1"],"picked":"Singing Bowl","floor":40.0},{"not_picked":["Bloodletting+1","Inflame"],"picked":"Barricade","floor":42.0},{"not_picked":["Inflame+1","Twin Strike","Bloodletting+1"],"picked":"Singing Bowl","floor":44.0},{"not_picked":["Havoc","Armaments","Rampage+1"],"picked":"Singing Bowl","floor":45.0},{"not_picked":["Spot Weakness","Anger"],"picked":"Dual Wield","floor":46.0},{"not_picked":["Heavy Blade","True Grit","Flex+1"],"picked":"Singing Bowl","floor":47},{"not_picked":["Feed","Bloodletting","Anger+1"],"picked":"Singing Bowl","floor":54}],"player_experience":3436837,"relics_obtained":[{"floor":6.0,"key":"Akabeko"},{"floor":9.0,"key":"PreservedInsect"},{"floor":14.0,"key":"Bag of Preparation"},{"floor":23.0,"key":"Singing Bowl"},{"floor":26.0,"key":"Smiling Mask"},{"floor":40.0,"key":"Vajra"},{"floor":42.0,"key":"Regal Pillow"},{"floor":46.0,"key":"Oddly Smooth Stone"},{"floor":54,"key":"Calipers"}],"event_choices":[{"damage_healed":0.0,"max_hp_gain":0.0,"max_hp_loss":0.0,"gold_gain":0.0,"event_name":"Golden Idol","player_choice":"Take Damage","floor":10.0,"gold_loss":0.0,"damage_taken":20.0,"relics_obtained":["Golden Idol"]},{"damage_healed":0.0,"max_hp_gain":0.0,"max_hp_loss":0.0,"gold_gain":0.0,"event_name":"WeMeetAgain","player_choice":"Gave Potion","floor":11.0,"gold_loss":0.0,"damage_taken":0.0,"relics_obtained":["Bag of Marbles"]},{"damage_healed":0.0,"max_hp_gain":0.0,"max_hp_loss":0.0,"gold_gain":99.0,"event_name":"Nest","player_choice":"Stole From Cult","floor":30.0,"gold_loss":0.0,"damage_taken":0.0},{"damage_healed":0.0,"max_hp_gain":0.0,"max_hp_loss":0.0,"gold_gain":0.0,"event_name":"Duplicator","player_choice":"Copied","floor":31.0,"gold_loss":0.0,"damage_taken":0.0,"cards_obtained":["Impervious"]},{"damage_healed":0.0,"max_hp_gain":0.0,"max_hp_loss":0.0,"gold_gain":0.0,"event_name":"Match and Keep!","player_choice":"1 cards matched","floor":37.0,"gold_loss":0.0,"damage_taken":0.0,"cards_obtained":["Reaper"]}],"is_beta":false,"boss_relics":[{"not_picked":["Black Blood","Busted Crown"],"picked":"Tiny House"},{"not_picked":["SacredBark","Runic Dome"],"picked":"Velvet Choker"}],"items_purged_floors":[8,20,27,48,53],"is_endless":false,"potions_floor_spawned":[3,4,6,14,16,19,24,28,33,35,36,42,46],"ascension_level":0}',
]
