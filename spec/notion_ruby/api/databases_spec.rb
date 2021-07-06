# frozen_string_literal: true

RSpec.describe NotionRuby::API::Databases do
  let(:notion) { NotionRuby.new(access_token: NOTION_TOKEN, version: NOTION_VERSION) }
  let(:id) { '30f8638c-7bac-bd1c-62bf-81ce1fdb8069' }

  context 'databases' do
    it 'return a database', vcr: { cassette_name: 'database' } do
      databases = notion.databases(id)
      expect(databases['object']).to eql 'database'
    end

    it 'return databases', vcr: { cassette_name: 'databases' } do
      databases = notion.databases
      expect(databases['object']).to eql 'list'
    end

    it 'return filtered pages in a database', vcr: { cassette_name: 'database_query' } do
      query = { filter: { or: [{ property: 'title', text: { contains: 'A Notion Page' } }] } }
      databases = notion.databases(id).query(query)
      expect(databases['object']).to eql 'list'
    end
  end
end
