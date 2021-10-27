require 'json'

def img(raw_key, size=200)
  map = {
    # events
    'neow' =>  'misc/neow.png',
    'shop' =>  'misc/shop.png',
    'campfire' =>  'misc/campfire.png',
    'chest' => 'misc/chest.png',
    'boss_chest' => 'misc/boss_chest.png',
    # graphics
    'hp'   =>  'misc/hp.png',
    'gold' =>  'misc/gold.png',
    # random events
    'Liars Game' => 'events/liarsGame.jpg',
  }
  if map.key?(raw_key) then
    v = map[raw_key]
  else
    key = raw_key.gsub(/ /, '').gsub(/\u0027/, '')
    if key.include? "+" then
      key = key.gsub(/\+.*/, 'Plus')
    end
    v = 'all/' + key + '.png'
  end
  return "<img src='https://slaythereport-images.s3.ap-northeast-1.amazonaws.com/#{v}' alt='#{v}' style='width:#{size}pt'></img>"
end
