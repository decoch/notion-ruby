# frozen_string_literal: true

RSpec.describe NotionRuby::API::Databases do
  let(:notion) { NotionRuby.new(access_token: NOTION_TOKEN, version: NOTION_VERSION) }
  let(:id) { "3c088cf2-c27d-9b57-156f-53ae10195c95" }

  context "pages" do
    it "return a page", vcr: { cassette_name: "page" } do
      databases = notion.pages(id)
      expect(databases["object"]).to eql "page"
    end
  end
end
