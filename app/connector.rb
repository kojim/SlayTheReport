# frozen_string_literal: true

require 'rubygems'
require 'aws-sdk'
require 'json'
require 'twitter'

require_relative './floor'

class RunDataService
  def initialize
    @ddb = Aws::DynamoDB::Client.new(
      region: 'ap-northeast-1'
    )
  end

  def query_all
    resp = @ddb.scan(
      table_name: 'SlayTheReport'
    )
    resp.items.map do |e|
      Report.new(e['author'], e['runid'], JSON.parse(e['report2']))
    end
  end

  def query_by_author(name)
    resp = @ddb.query(
      table_name: 'SlayTheReport',
      key_condition_expression: 'author = :author',
      expression_attribute_values: { ':author' => name }
    )
    resp.items.map do |e|
      Report.new(e['author'], e['runid'], JSON.parse(e['report2']))
    end
  end

  def get_item(author, runid)
    result = @ddb.get_item(
      table_name: 'SlayTheReport',
      key: {
        author: author,
        runid: runid
      }
    )
    run = Run.new(result['item']['runfile'])
    report = Report.new(result['item']['author'], result['item']['runid'], JSON.parse(result['item']['report2']))
    [run, report]
  end

  def put_item(author, runid, runfile)
    @ddb.put_item(
      table_name: 'SlayTheReport',
      item: {
        author: author,
        runid: runid,
        runfile: runfile,
        report2: '{}'
      }
    )
  end

  def update_item(author, runid, title, floor_comment)
    @ddb.update_item(
      table_name: 'SlayTheReport',
      key: {
        author: author,
        runid: runid
      },
      attribute_updates: {
        'report2' => {
          'value' => JSON.generate({
                                     'title' => title,
                                     'floor_comment' => floor_comment
                                   }),
          'action' => 'PUT'
        }
      }
    )
  end
end

class TwitterService
  def initialize
    smc = Aws::SecretsManager::Client.new(region: 'ap-northeast-1')
    secrets = JSON.parse(smc.get_secret_value(secret_id: 'TwitterAPIKey')['secret_string'])
    @api_key =    secrets['TwitterAPIKey']
    @api_secret = secrets['TwitterAPIKeySecret']
  end

  def token_authenticate(token, secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key = @api_key
      config.consumer_secret = @api_secret
      config.access_token = token
      config.access_token_secret = secret
    end
  end
end
