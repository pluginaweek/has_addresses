require "#{File.dirname(__FILE__)}/../test_helper"

class RegionTest < Test::Unit::TestCase
  fixtures :countries, :regions, :addresses
  
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
    assert_invalid regions(:california), :abbreviation, 'C', 'C' * 6
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
end