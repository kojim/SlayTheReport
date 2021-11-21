# frozen_string_literal: true

require 'rubygems'
require 'aws-sdk'
require 'json'
require 'twitter'

require_relative './floor'

class RunDataService
  def initialize(ddb_and_name)
    @ddb = ddb_and_name[0]
    @table_name = ddb_and_name[1]
  end

  def query_all
    resp1 = @ddb.query(
      table_name: @table_name,
      index_name: 'pseudo_pk-last_modified-index',
      scan_index_forward: false,
      key_condition_expression: 'pseudo_pk = :pseudo_pk',
      expression_attribute_values: { ':pseudo_pk' => 'dummy' }
    )

    return [] if resp1.items.size == 0

    # 記事が増えたらトップページの同時表示件数を減らす予定
    # それまでは完全に冗長な実装だが気にするな
    last_modified = resp1.items.map { |e| e['last_modified'] }
    resp2 = @ddb.query(
      table_name: @table_name,
      index_name: 'pseudo_pk-last_modified-summary',
      scan_index_forward: false,
      key_condition_expression: 'pseudo_pk = :pseudo_pk AND last_modified BETWEEN :min AND :max',
      expression_attribute_values: {
        ':pseudo_pk' => 'dummy',
        ':min' => last_modified.min,
        ':max' => last_modified.max,
      }
    )
    resp2.items.map do |e|
      Report.new(
        e['author'],
        e['runid'],
        JSON.parse(e['report_summary']),
        RunSummary.new(e['run_summary'])
      )
    end
  end

  def query_authors
    resp = @ddb.query(
      table_name: @table_name,
      index_name: 'pseudo_pk-last_modified-index',
      scan_index_forward: false,
      key_condition_expression: 'pseudo_pk = :pseudo_pk',
      expression_attribute_values: { ':pseudo_pk' => 'dummy' }
    )
    resp.items.map do |e|
      e['author']
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
      Report.new(
        e['author'],
        e['runid'],
        JSON.parse(e['report_summary']),
        RunSummary.new(e['run_summary'])
      )
    end
  end

  def get_item(author, runid)
    result = @ddb.get_item(
      table_name: @table_name,
      key: { author: author, runid: runid }
    )
    Report.new(
      result['item']['author'],
      result['item']['runid'],
      JSON.parse(result['item']['report_summary']),
      JSON.parse(result['item']['report_body']),
      Run.new(result['item']['runfile'])
    )
  end

  def put_item(author, runid, runfile, run, password='')
    @ddb.put_item(
      table_name: @table_name,
      item: {
        author: author,
        runid: runid,
        last_modified: (Time.now.to_i * 1000).to_i,
        runfile: runfile,
        run_summary: JSON.generate(
          {
            victory: run.victory,
            floor_reached: run.floor_reached,
            ascension_level: run.ascension_level,
            character_chosen: run.character_chosen
          }
        ),
        report_summary: '{}',
        report_body: JSON.generate(
          {
            password: password
          }
        ),
        pseudo_pk: 'dummy'
      },
      condition_expression: 'author <> :author AND runid <> :runid',
      expression_attribute_values: { ':author' => author, ':runid' => runid }
    )
  end

  def update_item(author, runid, title, description, floor_comment, key_cards, key_cards_pos, key_relics, key_relics_pos, password='')
    @ddb.update_item(
      table_name: @table_name,
      key: { author: author, runid: runid },
      attribute_updates: {
        'last_modified' => {
          'value' => (Time.now.to_f * 1000).to_i,
          'action' => 'PUT'
        },
        'report_summary' => {
          'value' => JSON.generate(
            {
              'title' => title,
              'description' => description,
              'key_cards' => key_cards,
              'key_cards_pos' => key_cards_pos,
              'key_relics' => key_relics,
              'key_relics_pos' => key_relics_pos
            }
          ),
          'action' => 'PUT'
        },
        'report_body' => {
          'value' => JSON.generate(
            {
              'floor_comment' => floor_comment,
              'password' => password
            }
          ),
          'action' => 'PUT'
        }
      }
    )
  end

  def delete_item(author, runid)
    @ddb.delete_item(
      table_name: @table_name,
      key: { author: author, runid: runid }
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

class SaltService
  def self.salt
    smc = Aws::SecretsManager::Client.new(region: 'ap-northeast-1')
    JSON.parse(smc.get_secret_value(secret_id: 'HashSalt')['secret_string'])['salt']
  end
end

