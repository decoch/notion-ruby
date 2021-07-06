# frozen_string_literal: true

class NotionRuby
  module API
    module Users
      class Proxy < ::NotionRuby::ResourceProxy
      end

      def users(id, params = {})
        params = id if id.is_a? Hash
        path_prefix = !id.is_a?(Hash) && id ? "/v1/users/#{id}" : "/v1/users"
        Proxy.new(connection, path_prefix, params)
      end
    end
  end
end
