# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metro_relic/version'

Gem::Specification.new do |spec|
  spec.name          = "metro_relic"
  spec.version       = MetroRelic::VERSION
  spec.authors       = ["Brandon Farmer and Micah Cooper"]
  spec.email         = ["dev@hashrocket.com"]
  spec.description   = %q{Easily track custom newrelic metrics with a config file}
  spec.summary       = %q{Easily track custom newrelic metrics}
  spec.homepage      = "http://github.com/hashrocket/metro_relic"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
