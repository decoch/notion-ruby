# frozen_string_literal: true

require "notion_ruby"
require 'vcr'
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!
  config.before_record do |i|
    if ENV.key?('NOTION_API_TOKEN')
      i.request.headers['Authorization'].first.gsub!(ENV['NOTION_API_TOKEN'], '<NOTION_API_TOKEN>')
    end
    i.response.body.force_encoding('UTF-8')
  end
end

if File.exists? File.expand_path("../settings.yml", __FILE__)
  settings = YAML.load_file(File.expand_path('../settings.yml', __FILE__))
  NOTION_TOKEN = settings['access_token']
  NOTION_VERSION = settings['version']
else
  NOTION_TOKEN = ENV['TOKEN']
  NOTION_VERSION = ENV['VERSION']
end
