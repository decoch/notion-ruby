# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "multi_json"

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

      super(hash[:api_url] || "https://api.notion.com") do |builder|
        yield builder if block_given?
        builder.use Faraday::Response::RaiseNotionRubyError
        builder.use FaradayMiddleware::EncodeJson
        builder.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
        builder.adapter Faraday.default_adapter
      end

      headers["Authorization"] = "Bearer #{hash[:access_token]}" if hash.key?(:access_token)
      headers["Notion-Version"] = NOTION_VERSION
    end
  end
end
