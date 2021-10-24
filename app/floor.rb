require 'json'

class Floor

  attr_accessor :floor_id
  attr_accessor :image
  attr_accessor :text
  attr_accessor :gold
  attr_accessor :gold_diff
  attr_accessor :max_hp
  attr_accessor :hp
  attr_accessor :obtain_potions
  attr_accessor :obtain_relics
  attr_accessor :obtain_cards
  attr_accessor :obtain_chosen_cards
  attr_accessor :player_comment

  def initialize
    @floor_id            = 0
    @image               = 'no_image'
    @text                = 'no text'
    @gold                = -1
    @gold_diff           = -999
    @max_hp              = -1
    @hp                  = -1
    @obtain_potions      = []
    @obtain_relics       = []
    @obtain_cards        = []
    @obtain_chosen_cards = []
    @player_comment      = 'no comment'
  end

end

class Run
  attr_accessor :player
  attr_accessor :key_cards
  attr_accessor :key_relics
  attr_accessor :floors

  def self.generate_from_json(run_json)
    run_data = JSON.parse(run_json)
    result = Run.new
    result.player     = 'kojim2'
    result.key_cards  = ['sugoku tsuyoi card1', '2', '3']
    result.key_relics = ['snecko eye']

    result.floors = []
    result.floors << Floor.new
    result.floors[0].image = 'neow'
    result.floors[0].text = run_data['neow_bonus'] + '/' + run_data['neow_cost']
    run_data['path_per_floor'].each_with_index do |t,idx|
      f = Floor.new
      f.text = t
      f.floor_id = idx+1
      result.floors << f
    end

    run_data['card_choices'].each do |t|
      result.floors[t['floor'].to_i].obtain_chosen_cards << t
    end


    result
  end
end

