require "#{File.dirname(__FILE__)}/../test_helper"

class CountryTest < Test::Unit::TestCase
  fixtures :countries, :regions
  
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
  
  def test_should_not_require_calling_code
    assert_valid countries(:united_states), :calling_code, nil
  end
  
  def test_abbreviation_2_should_be_same_as_alpha_2_code
    assert_equal 'US', countries(:united_states).abbreviation_2
  end
  
  def test_abbreviation_3should_be_same_as_alpha_3_code
    assert_equal 'USA', countries(:united_states).abbreviation_3
  end
#  
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
end