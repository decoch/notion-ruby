# frozen_string_literal: true

require_relative "notion_ruby/version"
require_relative 'notion_ruby/connection'
require_relative 'notion_ruby/errors'

class NotionRuby
  attr_reader :connection

  def initialize(options = {}, &block)
    @options = options
    @block = block if block
    @connection = NotionRuby::Connection.new(options, &block)
  end
end
