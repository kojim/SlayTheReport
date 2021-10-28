require 'json'

class Floor

  attr_accessor :floor_id
  attr_accessor :image
  attr_accessor :text
  attr_accessor :gold
  attr_accessor :gold_diff
  attr_accessor :max_hp
  attr_accessor :hp
  attr_accessor :hp_diff
  attr_accessor :player_choise
  attr_accessor :obtain_objects
  attr_accessor :obtain_chosen_cards
  attr_accessor :upgrade_cards
  attr_accessor :remove_cards
  attr_accessor :player_comment

  def initialize
    @floor_id            = 0
    @image               = 'no_image'
    @text                = 'no text'
    @gold                = 99
    @gold_diff           = 99
    @max_hp              = -1
    @hp                  = -1
    @player_choise       = nil
    @hp_diff             = 0
    @obtain_objects      = []
    @obtain_chosen_cards = []
    @upgrade_cards       = []
    @remove_cards        = []
    @player_comment      = 'no comment'
  end

end

class Run
  attr_accessor :player
  attr_accessor :ascension_level
  attr_accessor :key_cards
  attr_accessor :key_relics
  attr_accessor :master_deck
  attr_accessor :relics
  attr_accessor :floors

  def self.generate_from_json(run_json)
    run_data = JSON.parse(run_json)
    result = Run.new
    result.player     = 'kojim2'
    result.ascension_level = 0
    if run_data['ascension_level'] != nil then
      result.ascension_level = run_data['ascension_level']
    end
    result.key_cards  = ['sugoku tsuyoi card1', '2', '3']
    result.key_relics = ['snecko eye']

    result.floors = []
    result.floors << Floor.new
    if run_data['neow_bonus'] != nil and run_data['neow_cost'] then
      result.floors[0].image = 'neow'
      result.floors[0].player_choise = run_data['neow_bonus'] + '/' + run_data['neow_cost']
    end
    run_data['path_per_floor'].each_with_index do |t,idx|
      f = Floor.new
      case t
      when 'T' then
        f.image = 'chest'
      when '$' then
        f.image = 'shop'
      end
      f.text = t
      f.floor_id = idx+1
      result.floors << f
    end

    run_data['card_choices'].each do |e|
      result.floors[e['floor'].to_i].obtain_chosen_cards << e
    end

    if run_data['boss_relics'] != nil then
      if run_data['boss_relics'].size >= 1 then
        result.floors[17].image = 'boss_chest'
        result.floors[17].obtain_chosen_cards << run_data['boss_relics'][0]
      end
      if run_data['boss_relics'].size >= 2 then
        result.floors[34].image = 'boss_chest'
        result.floors[34].obtain_chosen_cards << run_data['boss_relics'][1]
      end
    end

    run_data['damage_taken'].each do |e|
      result.floors[e['floor'].to_i].image = e['enemies']
    end

    run_data['event_choices'].each do |e|
      result.floors[e['floor'].to_i].image = e['event_name']
      result.floors[e['floor'].to_i].player_choise = e['player_choice']
      if e['cards_removed'] != nil then
        result.floors[e['floor'].to_i].remove_cards += e['cards_removed']
      end
      if e['cards_transformed'] != nil then
        result.floors[e['floor'].to_i].remove_cards += e['cards_transformed']
      end
      if e['cards_obtained'] != nil then
        result.floors[e['floor'].to_i].obtain_objects += e['cards_obtained']
      end
      if e['cards_upgraded'] != nil then
        result.floors[e['floor'].to_i].upgrade_cards += e['cards_upgraded']
      end
    end

    run_data['campfire_choices'].each do |e|
      result.floors[e['floor'].to_i].image = 'campfire'
      result.floors[e['floor'].to_i].player_choise = e['key']
      if e['key'] == 'SMITH' then
        result.floors[e['floor'].to_i].upgrade_cards << e['data']
      end
    end

    run_data['relics_obtained'].each do |e|
      result.floors[e['floor'].to_i].obtain_objects << e['key']
    end

    pre_gold = 99
    run_data['gold_per_floor'].each_with_index do |e, idx|
      result.floors[idx+1].gold = e
      result.floors[idx+1].gold_diff = e - pre_gold
      pre_gold = e
    end

    pre_hp = 0
    run_data['current_hp_per_floor'].each_with_index do |e, idx|
      result.floors[idx+1].hp = e
      result.floors[idx+1].hp_diff = e - pre_hp
      pre_hp = e
    end

    run_data['max_hp_per_floor'].each_with_index do |e, idx|
      result.floors[idx+1].max_hp = e
    end

    run_data['item_purchase_floors'].each_with_index do |e, idx|
      result.floors[e.to_i].obtain_objects << run_data['items_purchased'][idx]
    end

    run_data['items_purged_floors'].each_with_index do |e, idx|
      result.floors[e.to_i].remove_cards << run_data['items_purged'][idx]
    end

    run_data['potions_obtained'].each do |e|
      result.floors[e['floor'].to_i].obtain_objects << e['key']
    end

    result.master_deck = run_data['master_deck']
    result.relics = run_data['relics']
    result

  end
end

