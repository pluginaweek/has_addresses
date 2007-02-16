require "#{File.dirname(__FILE__)}/../test_helper"

class AddressTest < Test::Unit::TestCase
  fixtures :credit_cards, :countries, :regions, :addresses
  
  def setup
  end
  
  def valid_address
    addresses(:valid)
  end
  
  def test_valid_address
    assert_valid valid_address
  end
  
  def test_no_addressable_id
    assert_invalid valid_address, :addressable_id, nil
  end
  
  def test_no_addressable_type
    assert_invalid valid_address, :addressable_type, nil
  end
  
  def test_addressable
    assert_equal credit_cards(:valid), addresses(:valid).addressable
  end
  
  def test_region
    assert_equal regions(:california), addresses(:known_region).region
  end
  
  def test_invalid_postal_code
    assert_invalid valid_address, :postal_code, '123456', '1234', 'abcdef'
  end
  
  def test_region_id_and_custom_region
    a = Address.new
    a.addressable = credit_cards(:known_region)
    a.region = regions(:california)
    a.custom_region = 'Should not save'
    assert a.save
    assert a.region
    assert_nil a.custom_region
  end
  
  def test_country_with_known_region
    assert_equal countries(:united_states), addresses(:known_region).country
  end
  
  def test_country_with_custom_region
    assert_equal countries(:united_states), addresses(:custom_region).country
  end
  
  def test_region_name_with_known_region
    assert_equal 'California', addresses(:known_region).region_name
  end
  
  def test_region_name_with_custom_region
    assert_equal 'Anywhere', addresses(:custom_region).region_name
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
    assert_equal '1600 Amphitheatre Parkway, Mountain View, California  94043, United States', addresses(:known_region).single_line
  end
end