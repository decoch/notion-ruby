require 'faraday'
require 'faraday_middleware'
require 'multi_json'

class NotionRuby
  class Connection < Faraday::Connection
    attr_reader :hash

    def parallel_connection(adapter = :typhoeus)
      conn = self.class.new @hash
      conn.adapter adapter
      conn
    end

    def initialize(hash = {})
      @hash = hash
      access_token = hash[:access_token] if hash.has_key?(:access_token)
      version = hash[:version] if hash.has_key?(:version)

      super(hash[:api_url] || 'https://api.notion.com') do |builder|
        yield builder if block_given?
        builder.use Faraday::Response::RaiseGheeError
        builder.use FaradayMiddleware::EncodeJson
        builder.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
        builder.adapter Faraday.default_adapter
      end

      self.headers["Authorization"] = "Bearer #{access_token}" if access_token
      self.headers["Notion-Version"] = version if version
    end
  end
end
