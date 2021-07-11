# frozen_string_literal: true

class NotionRuby
  module API
    module Search
      class Proxy < ::NotionRuby::ResourceProxy
      end

      def search(params = {})
        path_prefix = "/v1/search"
        connection.post(path_prefix, params).body
      end
    end
  end
end
