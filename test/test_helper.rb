# Load the plugin testing framework
$:.unshift("#{File.dirname(__FILE__)}/../../../../test/plugin_test_helper/lib")
require 'rubygems'
require 'plugin_test_helper'

PluginAWeek::Has::Addresses.verbose = false

PluginAWeek::PluginMigrations.migrate('has_addresses')

# Run the migrations
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")
