# frozen_string_literal: true

require_relative "notion_ruby/version"
require_relative "notion_ruby/connection"
require_relative "notion_ruby/errors"
require_relative "notion_ruby/state_methods"
require_relative "notion_ruby/resource_proxy"
require_relative "notion_ruby/api/databases"
require_relative "notion_ruby/api/pages"

class NotionRuby
  attr_reader :connection

  include NotionRuby::API::Databases
  include NotionRuby::API::Pages

  def initialize(options = {}, &block)
    @options = options
    @block = block if block
    @connection = NotionRuby::Connection.new(options, &block)
  end
end
