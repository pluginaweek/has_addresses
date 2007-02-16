# Load the environment
ENV['RAILS_ENV'] ||= 'in_memory'
require File.dirname(__FILE__) + '/rails_root/config/environment.rb'

# Load the testing framework
require 'test_help'
silence_warnings { RAILS_ENV = ENV['RAILS_ENV'] }

# Get some additional help
require 'dry_validity_assertions'

# Run the plugin migrations
PluginAWeek::PluginMigrations::Migrator.current_plugin = 'acts_as_addressable'
PluginAWeek::PluginMigrations::Migrator.migrate(File.dirname(__FILE__) + '/../db/migrate')

# Run the migrations
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")

class Test::Unit::TestCase #:nodoc:
  self.use_transactional_fixtures = false
  self.use_instantiated_fixtures  = false
end