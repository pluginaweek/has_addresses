require "#{File.dirname(__FILE__)}/../test_helper"

class AddressTest < Test::Unit::TestCase
  fixtures :companies, :countries, :regions, :addresses
  
  def test_address_in_known_region_should_be_valid
    assert_valid addresses(:in_known_region)
  end
  
  def test_address_in_unknown_region_should_be_valid
    assert_valid addresses(:in_unknown_region)
  end
  
  def test_should_require_addressable_id
    assert_invalid addresses(:google_headquarters), :addressable_id, nil
  end
  
  def test_should_require_addressable_type
    assert_invalid addresses(:google_headquarters), :addressable_type, nil
  end
  
  def test_should_require_street_1
    assert_invalid addresses(:google_headquarters), :street_1, nil
  end
  
  def test_should_require_city
    assert_invalid addresses(:google_headquarters), :city, nil
  end
  
  def test_should_require_postal_code
    assert_invalid addresses(:google_headquarters), :postal_code, nil
  end
  
  def test_should_require_five_digit_postal_codes
    assert_invalid addresses(:google_headquarters), :postal_code, '123456', '1234', 'abcdef'
  end
  
  def test_should_require_region_id_if_country_has_regions
    assert_invalid addresses(:in_known_region), :region_id, nil
  end
  
  def test_should_not_require_custom_region_if_country_has_regions
    assert_valid addresses(:in_known_region), :custom_region, nil
  end
  
  def test_should_require_custom_region_if_country_has_no_regions
    assert_invalid addresses(:in_unknown_region), :custom_region, nil
  end
  
  def test_should_not_require_region_id_if_country_has_no_regions
    assert_valid addresses(:in_unknown_region), :region_id, nil
  end
  
  def test_should_have_addressable_association
    assert_not_nil addresses(:google_headquarters).addressable
  end
  
  def test_known_region_should_have_region_association
    assert_not_nil addresses(:in_known_region).region
  end
  
  def test_unknown_region_should_not_have_region_association
    assert_nil addresses(:in_unknown_region).region
  end
  
  def test_known_region_should_have_country_association
    assert_nil addresses(:in_known_region).country_id
    assert_not_nil addresses(:in_known_region).country
    assert_equal countries(:united_states), addresses(:in_known_region).country
  end
  
  def test_unknown_region_should_have_country_association
    assert_not_nil addresses(:in_unknown_region).country_id
    assert_not_nil addresses(:in_unknown_region).country
    assert_equal countries(:canada), addresses(:in_unknown_region).country
  end
  
  def test_should_clear_country_id_with_known_region
    address = addresses(:in_known_region)
    address.country = countries(:united_states)
    
    assert_not_nil address.country_id
    address.save!
    assert_nil address.country_id
  end
  
  def test_should_clear_custom_region_with_known_region
    address = addresses(:in_known_region)
    address.custom_region = 'Somewhere'
    
    assert_not_nil address.custom_region
    address.save!
    assert_nil address.custom_region
  end
  
  def test_region_name_shouild_use_region_association_when_known
    assert_equal 'California', addresses(:in_known_region).region_name
  end
  
  def test_region_name_should_use_custom_region_when_unknown
    assert_equal 'Anywhere', addresses(:in_unknown_region).region_name
  end
  
  def test_multiline
    a = Address.new
    a.street_1 = '123 Fake Street'
    assert_equal ['123 Fake Street'], a.multi_line
    
    a.street_2 = 'Apartment 456'
    expected = [
      '123 Fake Street',
      'Apartment 456'
    ]
    assert_equal expected, a.multi_line
    
    a.city = 'Somewhere'
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere'
    ]
    assert_equal expected, a.multi_line
    
    a.region = regions(:california)
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere, California',
      'United States'
    ]
    assert_equal expected, a.multi_line
    
    a.postal_code = '12345'
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere, California  12345',
      'United States'
    ]
    assert_equal expected, a.multi_line
    
    a.region = nil
    a.custom_region = 'Anywhere'
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere, Anywhere  12345'
    ]
    assert_equal expected, a.multi_line
    
    a.city = nil
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Anywhere  12345'
    ]
    assert_equal expected, a.multi_line
    
    a.postal_code = nil
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Anywhere'
    ]
    assert_equal expected, a.multi_line
  end
  
  def test_single_line
    assert_equal '1600 Amphitheatre Parkway, Mountain View, California  94043, United States', addresses(:google_headquarters).single_line
  end
end