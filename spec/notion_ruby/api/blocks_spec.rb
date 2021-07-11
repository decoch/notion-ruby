# frozen_string_literal: true

RSpec.describe NotionRuby::API::Blocks do
  let(:notion) { NotionRuby.new(access_token: NOTION_TOKEN, version: NOTION_VERSION) }
  let(:id) { "33dfce72-6c0b-b713-65bd-839f47aa68f2" }
  let(:append_param) do
    {
      "children": [
        {
          object: "block",
          type: "heading_2",
          heading_2: { text: [{ type: "text", text: { content: "Lacinato kale" } }] }
        },
        {
          object: "block",
          type: "paragraph",
          paragraph: {
            text: [
              {
                type: "text",
                text: {
                  content: "example content",
                  link: { "url": "https://en.wikipedia.org/wiki/Lacinato_kale" }
                }
              }
            ]
          }
        }
      ]
    }
  end

  context "when children" do
    it "return children of the block", vcr: { cassette_name: "block_children" } do
      children = notion.blocks(id).children
      expect(children["object"]).to eql "list"
    end

    it "return appended children of the block", vcr: { cassette_name: "block_children_append" } do
      response = notion.blocks(id).children.append(append_param)
      expect(response["object"]).to eql "block"
    end
  end
end
