# Sequel::Schema::Dot::Generator

Sequel database structure Dot language generator

[![Gem Version](https://badge.fury.io/rb/sequel-schema-dot-generator.png)](http://badge.fury.io/rb/sequel-schema-dot-generator)

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog

### 0.0.4
- Module structure flattened
- Dir structure flattened
- active_support -> activesupport, smaller adjustments
- Transition to Ruby 2.0 and .ruby-version files for gem development

### 0.0.3
- Associations detection from model (`params[:schema_source_type] = :model`)
- New homepage

### 0.0.2
- optional colored association edges to distinguish them in big intersections (`params[:colored_associations]`)
- multiple foreign table support
- columns has written types in diagram
