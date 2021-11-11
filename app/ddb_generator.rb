# frozen_string_literal: true

class DDBGenerator
  def self.run(tag)
    case tag
    when :staging
      [Aws::DynamoDB::Client.new(region: 'ap-northeast-1'), 'SlayTheReport-v3s']
    when :production
      [Aws::DynamoDB::Client.new(region: 'ap-northeast-1'), 'SlayTheReport-v3p']
    when :local
      [Aws::DynamoDB::Client.new(endpoint: 'http://dynamodb:8000', region: 'ap-northeast-1', access_key_id: 'fakeid', secret_access_key: 'fakekey'), 'SlayTheReport']
    end
  end
end
