# frozen_string_literal: true

RSpec.describe NotionRuby do
  it "has a version number" do
    expect(NotionRuby::VERSION).not_to be nil
  end

  it "handle as a object with mashify", vcr: { cassette_name: "database" } do
    notion = NotionRuby.new(access_token: NOTION_TOKEN) do |builder|
      builder.use FaradayMiddleware::Mashify
    end
    databases = notion.databases("30f8638c-7bac-bd1c-62bf-81ce1fdb8069")
    expect(databases.object).to eql "database"
  end
end
