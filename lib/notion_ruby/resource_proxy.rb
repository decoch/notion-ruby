class NotionRuby

  # ResourceProxy lets us create a virtual
  # proxy for any API resource, utilizing
  # method_missing to handle passing
  # messages to the real object
  #
  class ResourceProxy
    # Undefine methods that might get in the way
    instance_methods.each { |m| undef_method m unless m =~ /^__|instance_eval|instance_variable_get|object_id|respond_to|class/ }

    include NotionRuby::CUD

    # Make connection and path_prefix readable
    attr_reader :connection, :path_prefix, :params, :id

    # Instantiates proxy with the connection
    # and path_prefix
    #
    # connection - [NotionRuby::Connection] object
    # path_prefix - String
    # param - Hash or String
    #
    def initialize(connection, path_prefix, params = {}, &block)
      unless params.is_a? Hash
        @id = params
        params = {}
      end
      @connection = connection
      @path_prefix = path_prefix
      @params = params
      @block = block if block
      subject if block
    end

    # Method_missing takes any message passed
    # to the ResourceProxy and sends it to the
    # real object
    #
    # message - Message object
    # args* - Arguments passed
    #
    def method_missing(message, *args, &block)
      subject.send(message, *args, &block)
    end

    # Raw is the raw response from the faraday
    # Use this if you need access to status codes
    # or header values
    #
    def raw
      connection.get(path_prefix) { |req| req.params.merge! params }
    end

    # Subject is the response body parsed
    # as json
    #
    # Returns json
    #
    def subject
      @subject ||= connection.get(path_prefix) do |req|
        req.params.merge! params
        @block.call(req) if @block
      end.body
    end

    def build_prefix(first_argument, endpoint)
      (!first_argument.is_a?(Hash) && !first_argument.nil?) ?
        File.join(path_prefix, "/#{endpoint}/#{first_argument}") : File.join(path_prefix, "/#{endpoint}")
    end

    private
  end
end
