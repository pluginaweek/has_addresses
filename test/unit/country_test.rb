require "#{File.dirname(__FILE__)}/../test_helper"

unless ENV['LIVE']
  Country::ISO_3166_URL = "#{RAILS_ROOT}/../files/iso_3166.xml"
end

class CountryTest < Test::Unit::TestCase
  fixtures :countries, :regions
  
  def test_should_download_and_parse_countries_from_iso_standard
    countries = Country.download_all
    assert_instance_of Array, countries
    assert !countries.empty?
  end
  
  def test_bootstrap_should_remove_existing_records
    country = Country.create(:name => 'Test', :alpha_2_code => 'TE', :alpha_3_code => 'TES')
    assert !country.new_record?
    Country.bootstrap
    assert_nil Country.find_by_name('Test')
  end
  
  def test_bootstrap_should_insert_downloaded_countries
    Country.bootstrap
    assert Country.count > 2
  end
  
  def test_bootstrap_should_return_true_if_successful
    assert Country.bootstrap
  end
  
  def test_should_use_default_path_for_created_fixture
    Country.create_fixtures
    assert File.exists?("#{RAILS_ROOT}/db/bootstrap/countries.yml")
  end
  
  def test_should_allow_custom_path_for_created_fixture
    Country.create_fixtures('db/bootstrap/the_countries.yml')
    assert File.exists?("#{RAILS_ROOT}/db/bootstrap/the_countries.yml")
  end
  
  def test_created_fixture_should_load_into_table
    Country.create_fixtures
    Fixtures.create_fixtures("#{RAILS_ROOT}/db/bootstrap", 'countries')
    assert Country.count > 2
  end
  
  def test_should_be_valid
    assert_valid countries(:united_states)
  end
  
  def test_should_require_name
    assert_invalid countries(:united_states), :name, nil
  end
  
  def test_should_restrict_name_length
    assert_invalid countries(:united_states), :name, 'U', 'U' * 81
    assert_valid countries(:united_states), :name, 'US', 'U' * 80
  end
  
  def test_should_require_unique_name
    assert_invalid countries(:united_states).clone, :name
  end
  
  def test_should_require_alpha_2_code
    assert_invalid countries(:united_states), :alpha_2_code, nil
  end
  
  def test_should_restrict_alpha_2_code_length
    assert_invalid countries(:united_states), :alpha_2_code, 'U', 'USA'
    assert_valid countries(:united_states), :alpha_2_code, 'US'
  end
  
  def test_should_require_unique_alpha_2_code
    assert_invalid countries(:united_states).clone, :alpha_2_code
  end
  
  def test_should_require_alpha_3_code
    assert_invalid countries(:united_states), :alpha_3_code, nil
  end
  
  def test_should_restrict_alpha_3_code_length
    assert_invalid countries(:united_states), :alpha_3_code, 'US', 'USAC'
    assert_valid countries(:united_states), :alpha_3_code, 'USA'
  end
  
  def test_should_require_unique_alpha_3_code
    assert_invalid countries(:united_states).clone, :alpha_3_code
  end
  
  def test_abbreviation_2_should_be_same_as_alpha_2_code
    assert_equal 'US', countries(:united_states).abbreviation_2
  end
  
  def test_abbreviation_3should_be_same_as_alpha_3_code
    assert_equal 'USA', countries(:united_states).abbreviation_3
  end
  
  def test_should_have_an_official_name
    assert_equal 'United States of America', countries(:united_states).official_name
  end
  
  def test_should_use_name_when_official_name_is_not_present
    assert_equal 'Canada', countries(:canada).official_name
  end
  
  def test_should_return_name_for_to_s
    assert_equal 'United States', countries(:united_states).to_s
    assert_equal 'Canada', countries(:canada).to_s
  end
  
  def test_regions
    assert_equal [regions(:california)], countries(:united_states).regions
  end
  
  def teardown
    FileUtils.rmtree("#{RAILS_ROOT}/db/bootstrap")
  end
end
