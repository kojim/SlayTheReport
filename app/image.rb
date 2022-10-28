# frozen_string_literal: true

require 'json'

def img(raw_key, _size = 200)
  map = {
    # events
    'neow' => 'misc/neow.png',
    'shop' => 'misc/shop.png',
    'campfire' => 'misc/campfire.png',
    'chest' => 'misc/chest.png',
    'boss_chest' => 'misc/boss_chest.png',
    'door' => 'misc/door.png',
    # graphics
    'hp' => 'misc/panelHeart.png',
    'gold' => 'misc/panelGold.png',
    # map bosses
    'map_The Guardian' => 'minimap/guardian.png',
    'map_Hexaghost' => 'minimap/hexaghost.png',
    'map_Slime Boss' => 'minimap/slime.png',
    'map_Automaton' => 'minimap/automaton.png',
    'map_Collector' => 'minimap/collector.png',
    'map_Champ' => 'minimap/champ.png',
    'map_Awakened One' => 'minimap/awakened.png',
    'map_Time Eater' => 'minimap/timeeater.png',
    'map_Donu and Deca' => 'minimap/donu.png',
    'map_The Heart' => 'minimap/heart.png',
    # win images
    'IRONCLAD_win' => 'misc/IRONCLAD_win.png',
    'THE_SILENT_win' => 'misc/THE_SILENT_win.png',
    'DEFECT_win' => 'misc/DEFECT_win.png',
    'WATCHER_win' => 'misc/WATCHER_win.png'
  }
  if map.key?(raw_key)
    v = map[raw_key]
  else
    key = raw_key.gsub(/ /, '').gsub(/\u0027/, '')
    key = key.gsub(/\+.*/, 'Plus') if key.include? '+'
    v = "all/#{key}.png"
  end
  "<img src='https://slaythereport-images.s3.ap-northeast-1.amazonaws.com/#{h(v)}' alt='#{h(v)}' data-rawname=\"#{h(raw_key)}\"/>"
end
