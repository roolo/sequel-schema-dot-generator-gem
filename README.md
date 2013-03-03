# Sequel::Schema::Dot::Generator

Sequel database structure Dot language generator

## Installation

Add this line to your application's Gemfile:

    gem 'sequel-schema-dot-generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-schema-dot-generator

## Usage

    require 'sequel/schema/dot/generator'

    dot_db = Sequel::Schema::Dot::Generator::Generator
      .new({  db:     DB
           }
      )

    puts dot_db.generate

    =>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
