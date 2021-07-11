# frozen_string_literal: true

RSpec.describe NotionRuby::API::Pages do
  let(:notion) { NotionRuby.new(access_token: NOTION_TOKEN) }
  let(:id) { "3c088cf2-c27d-9b57-156f-53ae10195c95" }
  let(:create_params) do
    {
      parent: { database_id: "30f8638c-7bac-bd1c-62bf-81ce1fdb8069" },
      properties: {
        Name: {
          title: [
            {
              text: {
                content: "Tuscan Kale"
              }
            }
          ]
        }
      }
    }
  end
  let(:update_params) do
    {
      properties: {
        Name: {
          title: [
            {
              text: {
                content: "Updated"
              }
            }
          ]
        }
      }
    }
  end

  it "return a page", vcr: { cassette_name: "page" } do
    pages = notion.pages(id)
    expect(pages["object"]).to eql "page"
  end

  it "create a page", vcr: { cassette_name: "page_create" } do
    page = notion.pages.create(create_params)
    expect(page["object"]).to eql "page"
  end

  it "update a page", vcr: { cassette_name: "page_update" } do
    databases = notion.pages(id).update(update_params)
    expect(databases["object"]).to eql "page"
  end
end
