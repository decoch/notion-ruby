# frozen_string_literal: true

class NotionRuby
  module API
    module Databases
      class Proxy < ::NotionRuby::ResourceProxy
        def query(params)
          connection.post("#{path_prefix}/query", params).body
        end
      end

      def databases(id = nil, params = {})
        params = id if id.is_a? Hash
        path_prefix = !id.is_a?(Hash) && id ? "/v1/databases/#{id}" : "/v1/databases"
        Proxy.new(connection, path_prefix, params)
      end
    end
  end
end
