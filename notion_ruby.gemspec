# frozen_string_literal: true

require_relative "lib/notion_ruby/version"

Gem::Specification.new do |spec|
  spec.name          = "notion_ruby"
  spec.version       = NotionRuby::VERSION
  spec.authors       = ["decoch"]
  spec.email         = ["tominaga.switch@gmail.com"]

  spec.summary       = "Access Notion in ruby."
  spec.description   = "A simple notion client api."
  spec.homepage      = "https://github.com/decoch/notion-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "hashie", "~> 3.3.2"
  spec.add_dependency "highline", "~> 1.6.15"
  spec.add_dependency "multi_json", "~> 1.3"
  spec.add_dependency "typhoeus", "~> 0.7.0"

  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
