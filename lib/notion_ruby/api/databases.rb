class NotionRuby

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Databases module handles all of the Notion Databases
    # API endpoints
    #
    module Databases
      class Proxy < ::NotionRuby::ResourceProxy

        # Query databases
        #
        # Returns json
        #
        def query(params)
          connection.post("#{path_prefix}/query", params).body
        end
      end

      # Get databases
      #
      # Returns json
      #
      def databases(id = nil, params = {})
        params = id if id.is_a? Hash
        path_prefix = (!id.is_a?(Hash) && id) ? "/v1/databases/#{id}" : '/v1/databases'
        Proxy.new(connection, path_prefix, params)
      end
    end
  end
end
