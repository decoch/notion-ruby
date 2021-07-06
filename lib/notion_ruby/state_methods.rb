class NotionRuby
  module CUD

    # Create
    #
    # return json
    #
    def get(attributes, &block)
      connection.get(path_prefix, attributes, &block).body
    end

    # Create
    #
    # return json
    #
    def create(attributes, &block)
      connection.post(path_prefix, attributes, &block).body
    end

    # Patch
    #
    # return json
    #
    def patch(attributes, &block)
      connection.patch(path_prefix, attributes, &block).body
    end
  end
end
