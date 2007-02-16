require "#{File.dirname(__FILE__)}/../test_helper"

class RegionTest < Test::Unit::TestCase
  fixtures :countries, :regions, :addresses
  
  def setup
  end
  
  def valid_region
    regions(:valid)
  end
  
  def test_valid_region
    assert_valid valid_region
  end
  
  def test_no_name
    assert_invalid valid_region, :name, nil
  end
  
  def test_name_length
    assert_invalid valid_region, :name, 'A', 'A' * 81
    assert_valid valid_region, :name, 'AB', 'A' * 80
  end
  
  def test_no_abbreviation
    assert_invalid valid_region, :abbreviation, nil
  end
  
  def test_abbreviation_length
    assert_invalid valid_region, :abbreviation, 'A', 'A' * 6
    assert_valid valid_region, :abbreviation, 'AB', 'A' * 5
  end
  
  def test_unique_attributes
    r = Region.new(valid_region.attributes)
    assert_invalid r, :name
    assert_invalid r, :abbreviation
    
    r.country = countries(:united_states)
    assert_valid r, :name
    assert_valid r, :abbreviation
  end
  
  def test_country
    assert_equal countries(:united_states), regions(:california).country
  end
  
  def test_addresses
    assert_equal [addresses(:known_region)], regions(:california).addresses
  end
  
  def test_to_s
    assert_equal 'California', regions(:california).to_s
  end
end