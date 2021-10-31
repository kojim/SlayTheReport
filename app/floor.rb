# frozen_string_literal: true

require 'json'

class Floor
  attr_accessor :floor_id, :image, :text, :gold, :gold_diff, :max_hp, :hp, :hp_diff, :player_choise, :obtain_objects,
                :obtain_chosen_cards, :upgrade_cards, :remove_cards

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
  end
end

class Run
  attr_accessor :ascension_level, :seed_text, :master_deck, :relics, :floors

  def initialize(run_json)
    run_data = JSON.parse(run_json)
    @raw_json = run_data
    @ascension_level = 0
    @ascension_level = run_data['ascension_level'] unless run_data['ascension_level'].nil?

    @floors = []
    @floors << Floor.new
    if !run_data['neow_bonus'].nil? && run_data['neow_cost']
      @floors[0].image = 'neow'
      @floors[0].player_choise = "#{run_data['neow_bonus']}/#{run_data['neow_cost']}"
    end

    run_data['path_per_floor'].each_with_index do |t, idx|
      f = Floor.new
      case t
      when 'T'
        f.image = 'chest'
      when '$'
        f.image = 'shop'
      end
      f.text = t
      f.floor_id = idx + 1
      @floors << f
    end

    if (@ascension_level < 20) && (@floors.size >= 52)
      @floors[51].image = 'door'
    elsif (@ascension_level >= 20) && (@floors.size >= 53)
      @floors[52].image = 'door'
    end

    run_data['card_choices'].each do |e|
      @floors[e['floor'].to_i].obtain_chosen_cards << e
    end

    unless run_data['boss_relics'].nil?
      if run_data['boss_relics'].size >= 1
        @floors[17].image = 'boss_chest'
        @floors[17].obtain_chosen_cards << run_data['boss_relics'][0]
      end
      if run_data['boss_relics'].size >= 2
        @floors[34].image = 'boss_chest'
        @floors[34].obtain_chosen_cards << run_data['boss_relics'][1]
      end
    end

    run_data['damage_taken'].each do |e|
      @floors[e['floor'].to_i].image = e['enemies']
    end

    run_data['event_choices'].each do |e|
      @floors[e['floor'].to_i].image = e['event_name']
      @floors[e['floor'].to_i].player_choise = e['player_choice']
      @floors[e['floor'].to_i].remove_cards += e['cards_removed'] unless e['cards_removed'].nil?
      @floors[e['floor'].to_i].remove_cards += e['cards_transformed'] unless e['cards_transformed'].nil?
      @floors[e['floor'].to_i].obtain_objects += e['cards_obtained'] unless e['cards_obtained'].nil?
      @floors[e['floor'].to_i].upgrade_cards += e['cards_upgraded'] unless e['cards_upgraded'].nil?
      @floors[e['floor'].to_i].obtain_objects += e['relics_obtained'] unless e['relics_obtained'].nil?
    end

    run_data['campfire_choices'].each do |e|
      @floors[e['floor'].to_i].image = 'campfire'
      @floors[e['floor'].to_i].player_choise = e['key']
      @floors[e['floor'].to_i].upgrade_cards << e['data'] if e['key'] == 'SMITH'
    end

    run_data['relics_obtained'].each do |e|
      @floors[e['floor'].to_i].obtain_objects << e['key']
    end

    pre_gold = 99
    run_data['gold_per_floor'].each_with_index do |e, idx|
      @floors[idx + 1].gold = e
      @floors[idx + 1].gold_diff = e - pre_gold
      pre_gold = e
    end

    pre_hp = @floors[0].hp = run_data['current_hp_per_floor'][0]
    run_data['current_hp_per_floor'].each_with_index do |e, idx|
      @floors[idx + 1].hp = e
      @floors[idx + 1].hp_diff = e - pre_hp
      pre_hp = e
    end

    @floors[0].max_hp = run_data['max_hp_per_floor'][0]
    run_data['max_hp_per_floor'].each_with_index do |e, idx|
      @floors[idx + 1].max_hp = e
    end

    run_data['item_purchase_floors'].each_with_index do |e, idx|
      @floors[e.to_i].obtain_objects << run_data['items_purchased'][idx]
    end

    run_data['items_purged_floors'].each_with_index do |e, idx|
      @floors[e.to_i].remove_cards << run_data['items_purged'][idx]
    end

    run_data['potions_obtained'].each do |e|
      @floors[e['floor'].to_i].obtain_objects << e['key']
    end

    @master_deck = run_data['master_deck']
    @relics = run_data['relics']
    @seed_text = convert_raw_seed_to_string(run_data['seed_played'].to_i)
  end

  attr_reader :raw_json

  # 4205495799455053197 should convert to 18JIMLWZV7HTH
  # -3363429452019887060 should convert to 4G7UMG8L17P0W
  def convert_raw_seed_to_string(seed)
    char_string = '0123456789ABCDEFGHIJKLMNPQRSTUVWXYZ'

    # Convert to unsigned
    seed += 2**64 if seed.negative?
    leftover = seed
    char_count = char_string.size
    result = []
    while leftover != 0
      remainder = leftover % char_count
      leftover /= char_count
      index = remainder.to_i
      c = char_string[index]
      result << c
    end
    result.reverse.join
  end
end

class Report
  attr_accessor :author, :run_id, :title, :key_cards, :key_relics, :floor_comment

  def initialize(author, run_id, report2)
    @author        = author
    @run_id        = run_id
    @title         = report2.fetch('title', run_id)
    @key_cards     = report2.fetch('key_cards', [])
    @key_relics    = report2.fetch('key_relics', [])
    @floor_comment = if report2['floor_comment'].nil?
                       []
                     else
                       # @floor_comment = JSON.parse(report2['floor_comment'])
                       report2['floor_comment']
                     end
  end
end
