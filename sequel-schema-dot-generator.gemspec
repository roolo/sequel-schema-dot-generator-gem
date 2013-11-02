# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path 'lib/sequel_schema_dot_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'sequel-schema-dot-generator'
  spec.version       = SequelSchemaDotGenerator::VERSION
  spec.authors       = ['Mailo Svetel']
  spec.email         = %w(development@rooland.cz)
  spec.description   = %q{This gem makes it easier to generate database schema overview image}
  spec.summary       = %q{Dot language format generator for Sequel schema structure}
  spec.homepage      = 'http://www.rooland.cz/sequel-schema-dot-generator-gem'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'sequel'
  spec.add_dependency 'activesupport'
end
