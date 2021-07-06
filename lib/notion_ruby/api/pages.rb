# frozen_string_literal: true

class NotionRuby
  module API
    # The Pages module handles all of the Notion Pages
    # API endpoints
    module Pages
      class Proxy < ::NotionRuby::ResourceProxy
        # Create page
        def create(params)
          connection.post(path_prefix, params).body
        end

        # Update page
        def update(params)
          connection.put(path_prefix, params).body
        end
      end

      # Get a page
      def pages(id = nil, params = {})
        params = id if id.is_a? Hash
        path_prefix = !id.is_a?(Hash) && id ? "/v1/pages/#{id}" : "/v1/pages"
        Proxy.new(connection, path_prefix, params)
      end
    end
  end
end
