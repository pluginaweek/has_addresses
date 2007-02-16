require "#{File.dirname(__FILE__)}/../test_helper"

class CountryTest < Test::Unit::TestCase
  fixtures :countries, :regions, :addresses
  
  def setup
    @united_states = countries(:united_states)
  end
  
  def valid_country
    countries(:valid)
  end
  
  def test_valid_country
    assert_valid valid_country
  end
  
  def test_no_name
    assert_invalid valid_country, :name, nil
  end
  
  def test_no_alpha_2_code
    assert_invalid valid_country, :alpha_2_code, nil
  end
  
  def test_no_alpha_3_code
    assert_invalid valid_country, :alpha_3_code, nil
  end
  
  def test_no_calling_code
    assert_valid valid_country, :calling_code, nil
  end
  
  def test_abbreviation_2
    assert_equal 'US', @united_states.abbreviation_2
  end
  
  def test_abbreviation_3
    assert_equal 'USA', @united_states.abbreviation_3
  end
  
  def test_official_name
    assert_equal 'United States of America', @united_states.official_name
  end
  
  def test_official_name_same_as_name
    assert_equal 'Valid', valid_country.official_name
  end
  
  def test_to_s
    assert_equal 'United States', @united_states.to_s
  end
  
  def test_regions
    assert_equal [regions(:california)], @united_states.regions
  end
  
  def test_addresses_with_known_regions
    assert_equal [addresses(:known_region)], @united_states.addresses_with_known_regions
  end
  
  def test_addresses_with_custom_regions
    assert_equal [addresses(:custom_region)], @united_states.addresses_with_custom_regions
  end
  
  def test_addresses
    assert_equal [addresses(:known_region), addresses(:custom_region)], @united_states.addresses
  end
end