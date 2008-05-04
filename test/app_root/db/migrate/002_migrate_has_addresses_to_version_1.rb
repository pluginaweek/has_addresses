class MigrateHasAddressesToVersion1 < ActiveRecord::Migration
  def self.up
    Rails::Plugin.find(:has_addresses).migrate(1)
  end
  
  def self.down
    Rails::Plugin.find(:has_addresses).migrate(0)
  end
end
