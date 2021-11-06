# frozen_string_literal: true

require 'rubygems'
require 'aws-sdk'
require 'json'
require 'twitter'

require_relative './floor'

class RunDataServiceLocal < RunDataService
  def initialize(table_name)
    @table_name = table_name
    @ddb = Aws::DynamoDB::Client.new(endpoint: 'http://localhost:8000', region: 'ap-northeast-1', acccess_key_id: 'fakeid', secret_access_key: 'fakekey')
  end
end
