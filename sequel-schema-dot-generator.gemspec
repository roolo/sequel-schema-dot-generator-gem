# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path 'lib/sequel/schema/dot/generator'

Gem::Specification.new do |spec|
  spec.name          = 'sequel-schema-dot-generator'
  spec.version       = Sequel::Schema::Dot::Generator::VERSION
  spec.authors       = ['Mailo Svetel']
  spec.email         = %w(development@rooland.cz)
  spec.description   = %q{This gem makes it easier to generate database schema overview image}
  spec.summary       = %q{Dot language format generator for Sequel schema structure}
  spec.homepage      = 'https://github.com/roolo/sequel-schema-dot-generator-gem'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'sequel'
  spec.add_dependency 'active_support'
end
