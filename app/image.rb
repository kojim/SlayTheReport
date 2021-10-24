require 'json'

def img(key, size=200)
  if key.include? "+" then
    key = key.gsub(/\+.*/, '')
  end
  map = {
    # events
    'neow' =>  'misc/neow.png',
    'shop' =>  'misc/shop.png',
    'campfire' =>  'misc/campfire.png',
    'chest' => 'misc/largeChest.png',
    # graphics
    'hp'   =>  'misc/hp.png',
    'gold' =>  'misc/gold.png',
    # random events
    'Liars Game' => 'events/liarsGame.jpg',
    # relics
    'Ancient Tea Set' => 'relics/tea_set.png',
    # Ironcrad cards
    'Bash'               =>  'cards/ironcrad/bash.png',
    'Anger'              =>  'cards/ironcrad/anger.png',
    'Armaments'          =>  'cards/ironcrad/armaments.png',
    'Body Slam'          =>  'cards/ironcrad/body_slam.png',
    'Clash'              =>  'cards/ironcrad/clash.png',
    'Cleave'             =>  'cards/ironcrad/cleave.png',
    'Clothesline'        =>  'cards/ironcrad/clothesline.png',
    'Flex'               =>  'cards/ironcrad/flex.png',
    'Havoc'              =>  'cards/ironcrad/havoc.png',
    'Headbutt'           =>  'cards/ironcrad/headbutt.png',
    'Heavy Blade'        =>  'cards/ironcrad/heavy_blade.png',
    'Iron Wave'          =>  'cards/ironcrad/iron_wave.png',
    'Perfected Strike'   =>  'cards/ironcrad/perfected_strike.png',
    'Pommel Strike'      =>  'cards/ironcrad/pommel_strike.png',
    'Shrug It Off'       =>  'cards/ironcrad/shrug_it_off.png',
    'Sword Boomerang'    =>  'cards/ironcrad/sword_boomerang.png',
    'Thunderclap'        =>  'cards/ironcrad/thunderclap.png',
    'True Grit'          =>  'cards/ironcrad/true_grit.png',
    'Twin Strike'        =>  'cards/ironcrad/twin_strike.png',
    'Warcry'             =>  'cards/ironcrad/warcry.png',
    'Wild Strike'        =>  'cards/ironcrad/wild_strike.png',
    'Battle Trance'      =>  'cards/ironcrad/battle_trance.png',
    'Blood for Blood'    =>  'cards/ironcrad/blood_for_blood.png',
    'Bloodletting'       =>  'cards/ironcrad/bloodletting.png',
    'Burning Pact'       =>  'cards/ironcrad/burning_pact.png',
    'Carnage'            =>  'cards/ironcrad/carnage.png',
    'Combust'            =>  'cards/ironcrad/combust.png',
    'Dark Embrace'       =>  'cards/ironcrad/dark_embrace.png',
    'Disarm'             =>  'cards/ironcrad/disarm.png',
    'Dropkick'           =>  'cards/ironcrad/dropkick.png',
    'Dual Wield'         =>  'cards/ironcrad/dual_wield.png',
    'Entrench'           =>  'cards/ironcrad/entrench.png',
    'Evolve'             =>  'cards/ironcrad/evolve.png',
    'Feel No Pain'       =>  'cards/ironcrad/feel_no_pain.png',
    'Fire Breathing'     =>  'cards/ironcrad/fire_bleathing.png',
    'Flame Barrier'      =>  'cards/ironcrad/flame_barrier.png',
    'Ghostly Armor'      =>  'cards/ironcrad/ghostly_armor.png',
    'Hemokinesis'        =>  'cards/ironcrad/hemokinesis.png',
    'Infernal Blade'     =>  'cards/ironcrad/infernal_blade.png',
    'Inflame'            =>  'cards/ironcrad/inflame.png',
    'Intimidate'         =>  'cards/ironcrad/intimidate.png',
    'Metallicize'        =>  'cards/ironcrad/metallicize.png',
    'Power Through'      =>  'cards/ironcrad/power_through.png',
    'Pummel'             =>  'cards/ironcrad/pummel.png',
    'Rage'               =>  'cards/ironcrad/rage.png',
    'Rampage'            =>  'cards/ironcrad/rampage.png',
    'Reckless Charge'    =>  'cards/ironcrad/reckless_charge.png',
    'Rupture'            =>  'cards/ironcrad/rapture.png',
    'Searing Blow'       =>  'cards/ironcrad/searing_blow.png',
    'Second Wind'        =>  'cards/ironcrad/second_wind.png',
    'Seeing Red'         =>  'cards/ironcrad/seeing_red.png',
    'Sentinel'           =>  'cards/ironcrad/sentinel.png',
    'Sever Soul'         =>  'cards/ironcrad/sever_soul.png',
    'Shockwave'          =>  'cards/ironcrad/shockwave.png',
    'Spot Weakness'      =>  'cards/ironcrad/spot_weakness.png',
    'Uppercut'           =>  'cards/ironcrad/uppercut.png',
    'Whirlwind'          =>  'cards/ironcrad/whirlwind.png',
    'Barricade'          =>  'cards/ironcrad/barricade.png',
    'Berserk'            =>  'cards/ironcrad/berserk.png',
    'Bludgeon'           =>  'cards/ironcrad/bludgeon.png',
    'Brutality'          =>  'cards/ironcrad/brutality.png',
    'Corruption'         =>  'cards/ironcrad/corruption.png',
    'Demon Form'         =>  'cards/ironcrad/daemon_form.png',
    'Double Tap'         =>  'cards/ironcrad/double_tap.png',
    'Exhume'             =>  'cards/ironcrad/exhume.png',
    'Feed'               =>  'cards/ironcrad/feed.png',
    'Fiend Fire'         =>  'cards/ironcrad/fiend_fire.png',
    'Immolate'           =>  'cards/ironcrad/immolate.png',
    'Impervious'         =>  'cards/ironcrad/impervious.png',
    'Juggernaut'         =>  'cards/ironcrad/juggernaut.png',
    'Limit Break'        =>  'cards/ironcrad/limit_break.png',
    'Offering'           =>  'cards/ironcrad/offering.png',
    'Reaper'             =>  'cards/ironcrad/reaper.png',
  }
  if map.key?(key) then
    v = map[key]
    if key.include? "+" then
      v = v.gsub(/\./, '_p.')
    end
    return "<img src='https://slaythereport-images.s3.ap-northeast-1.amazonaws.com/#{v}' style='width:#{size}pt'></img>"
  else
    return 'no-image: ' + key
  end
end
