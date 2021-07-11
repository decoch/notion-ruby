# NotionRuby

This is an unofficial ruby client for the [Notion API](https://developers.notion.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notion_ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install notion_ruby

## Usage

Instantiate the client with auth token:

```ruby
notion = NotionRuby.new({ access_token: 'dummy' }) 
```

### Databases

List databases:

```ruby
notion.databases
```

Retrieve a database:

```ruby
notion.databases("database_id")
```

Query a database:

```ruby
query = { filter: { or: [{ property: "title", text: { contains: "A Notion Page" } }] } }
response = notion.databases("database_id").query(query)
```

### Pages

Retrieve a page:

```ruby
pages = notion.pages("page_id")
```

Create a page:

```ruby
params = {
  parent: { database_id: "database_id" },
  properties: {
    Name: {
      title: [
        {
          text: {
            content: "Create"
          }
        }
      ]
    }
  }
}
response = notion.pages.create(params)
```

Update page:

```ruby
params = {
  properties: {
    Name: {
      title: [
        {
          text: {
            content: "Update"
          }
        }
      ]
    }
  }
}
response = notion.pages(id).update(params)
```

### Blocks

Retrieve block children:

```ruby
children = notion.blocks("block_id").children
```

Append block children:

```ruby
params = {
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
response = notion.blocks("block_id").children.append(params)
```

### User

Retrieve a user:

```ruby
user = notion.users("user_id")
```

List all users:

```ruby
notion.users
```

### Search

Search:

```ruby
response = notion.search({ query: "Example" })
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/decoch/notion-ruby. This project is intended
to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/decoch/notion-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NotionRuby project's codebases, issue trackers, chat rooms and mailing lists is expected to
follow the [code of conduct](https://github.com/decoch/notion-ruby/blob/main/CODE_OF_CONDUCT.md).
