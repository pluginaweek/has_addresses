# Load local repository plugin paths
$:.unshift("#{File.dirname(__FILE__)}/../../has_association_helper/lib")

# Load the plugin testing framework
$:.unshift("#{File.dirname(__FILE__)}/../../../../test/plugin_test_helper/lib")
require 'rubygems'
require 'plugin_test_helper'

PluginAWeek::PluginMigrations.migrate('has_addresses')

# Run the migrations
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")