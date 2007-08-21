namespace :countries do
  desc 'Generates a new fixtures file for the countries table'
  task :create_fixtures => :environment do
    Country.create_fixtures(ENV['OUTPUT'])
  end
  
  desc 'Bootstraps the countries table with the latest ISO 3166 standard'
  task :bootstrap => :environment do
    Country.bootstrap
  end
end

namespace :regions do
  desc 'Generates a new fixtures file for the regions table'
  task :create_fixture => :environment do
    Region.create_fixtures(ENV['OUTPUT'])
  end
  
  desc 'Bootstraps the regions table with the latest ISO 3166-2 standard'
  task :bootstrap => :environment do
    Region.bootstrap
  end
end
