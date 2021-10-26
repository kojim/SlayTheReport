# encoding: utf-8

require 'aws-sdk'
require 'json'

client = Aws::SecretsManager::Client.new(region: 'ap-northeast-1')
$Key = JSON.parse(client.get_secret_value(secret_id: 'TwitterAPIKey')['secret_string'])

