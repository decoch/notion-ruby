# frozen_string_literal: true

RSpec.describe NotionRuby::API::Users do
  let(:notion) { NotionRuby.new(access_token: NOTION_TOKEN, version: NOTION_VERSION) }
  let(:id) { "47bd6f41-3798-354a-749a-a6d229b974aa" }

  it "return a user", vcr: { cassette_name: "user" } do
    user = notion.users(id)
    expect(user["object"]).to eql "user"
  end

  it "return all users", vcr: { cassette_name: "users" } do
    users = notion.users
    expect(users["object"]).to eql "list"
  end
end
