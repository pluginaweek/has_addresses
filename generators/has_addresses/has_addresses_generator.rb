class HasAddressesGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template '001_create_countries.rb', 'db/migrate', :migration_file_name => 'create_countries'
      m.sleep 1
      m.migration_template '002_create_regions.rb', 'db/migrate', :migration_file_name => 'create_regions'
      m.sleep 1
      m.migration_template '003_create_addresses.rb', 'db/migrate', :migration_file_name => 'create_addresses'
    end
  end
end
