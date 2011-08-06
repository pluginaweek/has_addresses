$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'has_addresses/version'

Gem::Specification.new do |s|
  s.name              = "has_addresses"
  s.version           = HasAddresses::VERSION
  s.authors           = ["Aaron Pfeifer"]
  s.email             = "aaron@pluginaweek.org"
  s.homepage          = "http://www.pluginaweek.org"
  s.description       = "Demonstrates a reference implementation for handling countries, regions, and addresses in ActiveRecord"
  s.summary           = "Countries, regions, and addresses in ActiveRecord"
  s.require_paths     = ["lib"]
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- test/*`.split("\n")
  s.rdoc_options      = %w(--line-numbers --inline-source --title has_addresses --main README.rdoc)
  s.extra_rdoc_files  = %w(README.rdoc CHANGELOG.rdoc LICENSE)
  
  s.add_dependency("enumerate_by", ">= 0.4.1")
  s.add_development_dependency("rake")
  s.add_development_dependency("plugin_test_helper", ">= 0.3.2")
end
