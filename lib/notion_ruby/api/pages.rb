# frozen_string_literal: true

class NotionRuby
  module API
    module Pages
      class Proxy < ::NotionRuby::ResourceProxy
        def create(params)
          connection.post(path_prefix, params).body
        end

        def update(params)
          connection.patch(path_prefix, params).body
        end
      end

      def pages(id = nil, params = {})
        params = id if id.is_a? Hash
        path_prefix = !id.is_a?(Hash) && id ? "/v1/pages/#{id}" : "/v1/pages"
        Proxy.new(connection, path_prefix, params)
      end
    end
  end
end
