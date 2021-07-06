# frozen_string_literal: true

class NotionRuby
  module API
    module Search
      class Proxy < ::NotionRuby::ResourceProxy
      end

      def search(params = {})
        Proxy.new(connection, "/v1/search", params)
      end
    end
  end
end
