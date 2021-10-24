require 'json'

def img(key, size=200)
  map = {
    'neow' =>  'misc/neow.png',
    'shop' =>  'misc/shop.png',
    'campfire' =>  'misc/campfire.png',
    'hp'   =>  'misc/hp.png',
    'gold' =>  'misc/gold.png',
    'chest' => 'misc/largeChest.png',
    'Liars Game' => 'events/liarsGame.jpg',
    'Ancient Tea Set' => 'relics/tea_set.png',
  }
  if map.key?(key) then
    return "<img src='https://slaythereport-images.s3.ap-northeast-1.amazonaws.com/#{map[key]}' style='width:#{size}pt'></img>"
  else
    return "no-image: " + key
  end
end
