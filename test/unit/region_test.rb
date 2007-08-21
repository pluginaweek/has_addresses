require "#{File.dirname(__FILE__)}/../test_helper"

unless ENV['LIVE']
  Region::ISO_3166_2_URL = "#{RAILS_ROOT}/../files/iso_3166_2.xml"
end

class RegionTest < Test::Unit::TestCase
  fixtures :countries, :regions, :addresses
  
  def test_should_download_and_parse_regions_from_iso_standard
    regions = Region.download_all
    assert_instance_of Array, regions
    assert !regions.empty?
  end
  
  def test_bootstrap_should_remove_existing_records
    region = Region.create(:name => 'Test', :country_id => 840, :abbreviation => 'TE')
    assert !region.new_record?
    Region.bootstrap
    assert_nil Region.find_by_name('Test')
  end
  
  def test_bootstrap_should_insert_downloaded_regions
    Region.bootstrap
    assert Region.count > 1
  end
  
  def test_bootstrap_should_return_true_if_successful
    assert Region.bootstrap
  end
  
  def test_should_use_default_path_for_created_fixture
    Region.create_fixtures
    assert File.exists?("#{RAILS_ROOT}/db/bootstrap/regions.yml")
  end
  
  def test_should_allow_custom_path_for_created_fixture
    Region.create_fixtures('db/bootstrap/the_regions.yml')
    assert File.exists?("#{RAILS_ROOT}/db/bootstrap/the_regions.yml")
  end
  
  def test_created_fixture_should_load_into_table
    Region.create_fixtures
    Fixtures.create_fixtures("#{RAILS_ROOT}/db/bootstrap", 'regions')
    assert Region.count > 1
  end
  
  def test_should_be_valid
    assert_valid regions(:california)
  end
  
  def test_should_require_name
    assert_invalid regions(:california), :name, nil
  end
  
  def test_should_restrict_name_length
    assert_invalid regions(:california), :name, 'C', 'C' * 81
    assert_valid regions(:california), :name, 'Ca', 'C' * 80
  end
  
  def test_should_require_unique_name_per_country
    region = regions(:california).clone
    assert_invalid region, :name
    
    region.country = countries(:canada)
    assert_valid region, :name
  end
  
  def test_should_require_abbreviation
    assert_invalid regions(:california), :abbreviation, nil
  end
  
  def test_should_restrict_abbreviation_length
    assert_invalid regions(:california), :abbreviation, '', 'C' * 6
    assert_valid regions(:california), :abbreviation, 'CA', 'C' * 5
  end
  
  def test_should_require_unique_abbreviation_per_country
    region = regions(:california).clone
    assert_invalid region, :abbreviation
    
    region.country = countries(:canada)
    assert_valid region, :abbreviation
  end
  
  def test_should_belong_to_a_country
    assert_equal countries(:united_states), regions(:california).country
  end
  
  def test_should_have_many_addresses
    assert_equal [addresses(:in_known_region), addresses(:google_headquarters), addresses(:google_sales)], regions(:california).addresses
  end
  
  def test_should_use_name_for_stringification
    assert_equal 'California', regions(:california).to_s
  end
  
  def teardown
    FileUtils.rmtree("#{RAILS_ROOT}/db/bootstrap")
  end
end
