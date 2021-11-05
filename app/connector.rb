# frozen_string_literal: true

require 'rubygems'
require 'aws-sdk'
require 'json'
require 'twitter'

require_relative './floor'

class RunDataService
  def initialize(table_name)
    @table_name = table_name
    @ddb = Aws::DynamoDB::Client.new(region: 'ap-northeast-1')
  end

  def query_all
    resp1 = @ddb.query(
      table_name: @table_name,
      index_name: 'pseudo_pk-last_modified-index',
      scan_index_forward: false,
      key_condition_expression: 'pseudo_pk = :pseudo_pk',
      expression_attribute_values: { ':pseudo_pk' => 'dummy' }
    )
    return resp1.items.map do |e|
      resp2 = @ddb.query(
        table_name: @table_name,
        index_name: 'last_modified-index',
        key_condition_expression: 'author = :author and last_modified = :last_modified',
        expression_attribute_values: { ':author' => e['author'], ':last_modified' => e['last_modified'] }
      )
      Report.new(resp2.items[0]['author'], resp2.items[0]['runid'], JSON.parse(resp2.items[0]['report_summary']))
    end
  end

  def query_by_author(name)
    resp = @ddb.query(
      table_name: @table_name,
      index_name: 'last_modified-index',
      scan_index_forward: false,
      key_condition_expression: 'author = :author',
      expression_attribute_values: { ':author' => name }
    )
    resp.items.map do |e|
      Report.new(e['author'], e['runid'], JSON.parse(e['report_summary']))
    end
  end

  def get_item(author, runid)
    result = @ddb.get_item(
      table_name: @table_name,
      key: { author: author, runid: runid }
    )
    run = Run.new(result['item']['runfile'])
    report = Report.new(
      result['item']['author'],
      result['item']['runid'],
      JSON.parse(result['item']['report_summary']),
      JSON.parse(result['item']['report_body']))
    [run, report]
  end

  def put_item(author, runid, runfile, run)
    @ddb.put_item(
      table_name: @table_name,
      item: {
        author: author,
        runid: runid,
        last_modified: (Time.now.to_i * 1000).to_i,
        runfile: runfile,
        run_summary: JSON.generate({
          victory: run.victory,
          floor_reached: run.floor_reached,
          ascension_level: run.ascension_level,
          character_chosen: run.character_chosen
        }),
        report_summary: '{}',
        report_body: '{}',
        pseudo_pk: 'dummy'
      }
    )
  end

  def update_item(author, runid, title, floor_comment)
    @ddb.update_item(
      table_name: @table_name,
      key: { author: author, runid: runid },
      attribute_updates: {
        'last_modified' => {
          'value' => (Time.now.to_f * 1000).to_i,
          'action' => 'PUT'
        },
        'report_summary' => {
          'value' => JSON.generate({ 'title' => title }),
          'action' => 'PUT'
        },
        'report_body' => {
          'value' => JSON.generate({ 'floor_comment' => floor_comment }),
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
    return nil if token.nil? || secret.nil?

    Twitter::REST::Client.new do |config|
      config.consumer_key = @api_key
      config.consumer_secret = @api_secret
      config.access_token = token
      config.access_token_secret = secret
    end
  end

  def get_api_keys
    [@api_key, @api_secret]
  end
end
