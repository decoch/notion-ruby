# frozen_string_literal: true

RSpec.describe NotionRuby::API::Search do
  let(:notion) { NotionRuby.new(access_token: NOTION_TOKEN, version: NOTION_VERSION) }
  let(:id) { "30f8638c-7bac-bd1c-62bf-81ce1fdb8069" }

  it "return a database", vcr: { cassette_name: "search" } do
    databases = notion.search({ query: "Books" })
    expect(databases["object"]).to eql "list"
  end
end
