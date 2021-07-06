# frozen_string_literal: true

class NotionRuby
  module API
    module Blocks
      module Children
        class ChildrenProxy < ::Ghee::ResourceProxy
          def append(params)
            connection.patch(path_prefix, params).body
          end
        end
      end

      class Proxy < ::NotionRuby::ResourceProxy
        def children
          prefix = "#{path_prefix}/children"
          NotionRuby::API::Blocks::Children::Proxy.new(connection, prefix.name, &block)
        end
      end

      def blocks(id, params = {})
        Proxy.new(connection, "/v1/blocks/#{id}", params)
      end
    end
  end
end
