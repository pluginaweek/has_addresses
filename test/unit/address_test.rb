require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class AddressByDefaultTest < ActiveRecord::TestCase
  def setup
    @address = Address.new
  end
  
  def test_should_not_have_an_addressable_id
    assert_nil @address.addressable_id
  end
  
  def test_should_not_have_an_addressable_type
    assert @address.addressable_type.blank?
  end
  
  def test_should_not_have_a_street_1
    assert @address.street_1.blank?
  end
  
  def test_should_not_have_a_street_2
    assert @address.street_2.blank?
  end
  
  def test_should_not_have_a_city
    assert @address.city.blank?
  end
  
  def test_should_not_have_a_region
    assert_nil @address.region_id
  end
  
  def test_should_not_have_a_custom_region
    assert @address.custom_region.blank?
  end
  
  def test_should_not_have_a_region_name
    assert @address.region_name.blank?
  end
  
  def test_should_not_have_a_postal_code
    assert @address.postal_code.blank?
  end
  
  def test_should_not_have_a_country
    assert_nil @address.country_id
  end
  
  def test_should_not_have_any_address_lines
    assert @address.multi_line.empty?
  end
end

class AddressTest < ActiveRecord::TestCase
  def test_should_be_valid_with_a_set_of_valid_attributes
    address = new_address
    assert address.valid?
  end
  
  def test_should_require_an_addressable_id
    address = new_address(:addressable => nil)
    assert !address.valid?
    assert address.errors.invalid?(:addressable_id)
  end
  
  def test_should_require_an_addressable_type
    address = new_address(:addressable => nil)
    assert !address.valid?
    assert address.errors.invalid?(:addressable_type)
  end
  
  def test_should_require_a_street_1
    address = new_address(:street_1 => nil)
    assert !address.valid?
    assert address.errors.invalid?(:street_1)
  end
  
  def test_should_not_require_a_street_2
    address = new_address(:street_2 => nil)
    assert address.valid?
  end
  
  def test_should_require_a_city
    address = new_address(:city => nil)
    assert !address.valid?
    assert address.errors.invalid?(:city)
  end
  
  def test_should_require_a_postal_code
    address = new_address(:postal_code => nil)
    assert !address.valid?
    assert address.errors.invalid?(:postal_code)
  end
  
  def test_should_require_a_region_if_country_has_regions
    country = create_country
    create_region(:country => country)
    
    address = new_address(:country => country, :region => nil)
    assert !address.valid?
    assert address.errors.invalid?(:region_id)
  end
  
  def test_should_not_require_a_region_if_country_has_no_regions
    country = create_country
    
    address = new_address(:country => country, :region => nil, :custom_region => 'Somewhere')
    assert address.valid?
  end
  
  def test_should_require_a_custom_region_if_country_has_no_regions
    country = create_country
    
    address = new_address(:country => country, :region => nil, :custom_region => nil)
    assert !address.valid?
    assert address.errors.invalid?(:custom_region)
  end
  
  def test_should_not_require_a_custom_region_if_country_has_regions
    country = create_country
    region = create_region(:country => country)
    
    address = new_address(:country => country, :region => region, :custom_region => nil)
    assert address.valid?
  end
  
  def test_should_require_a_country
    address = new_address(:country => nil, :region => nil)
    assert !address.valid?
    assert address.errors.invalid?(:country_id)
  end
  
  def test_should_protect_attributes_from_mass_assignment
    country = create_country
    region = create_region(:country => country)
    
    address = Address.new(
      :id => 1,
      :addressable_id => 1,
      :addressable_type => 'User',
      :street_1 => '1600 Amphitheatre Parkway',
      :street_2 => 'Apt. 1',
      :city => 'Mountain View',
      :region => region,
      :custom_region => 'Anywhere',
      :postal_code => '94043',
      :country => country
    )
    
    assert_nil address.id
    assert_nil address.addressable_id
    assert address.addressable_type.blank?
    assert_equal '1600 Amphitheatre Parkway', address.street_1
    assert_equal 'Apt. 1', address.street_2
    assert_equal 'Mountain View', address.city
    assert_equal region, address.region
    assert_equal 'Anywhere', address.custom_region
    assert_equal '94043', address.postal_code
    assert_equal country, address.country
  end
end

class AddressAfterBeingCreatedTest < ActiveRecord::TestCase
  def setup
    @company = create_company
    @address = create_address(:addressable => @company)
  end
  
  def test_should_have_an_addressable_association
    assert_equal @company, @address.addressable
  end
end

class AddressInKnownRegionTest < ActiveRecord::TestCase
  def setup
    @country = create_country
    @region = create_region(:country => @country, :name => 'California')
    @address = create_address(:region => @region)
  end
  
  def test_should_have_a_region
    assert_not_nil @address.region
  end
  
  def test_should_have_a_region_name
    assert_equal 'California', @address.region_name
  end
  
  def test_should_have_a_country
    assert_equal @country, @address.country
  end
  
  def test_should_clear_custom_region
    @address.custom_region = 'Somewhere'
    @address.valid?
    assert_nil @address.custom_region
  end
end

class AddressInUnknownRegionTest < ActiveRecord::TestCase
  def setup
    @country = create_country
    @address = create_address(:country => @country, :region => nil, :custom_region => 'Somewhere')
  end
  
  def test_should_not_have_a_region
    assert_nil @address.region
  end
  
  def test_should_have_a_country
    assert_equal @country, @address.country
  end
  
  def test_should_have_a_region_name
    assert_equal 'Somewhere', @address.region_name
  end
end

class AddressConstructionTest < ActiveRecord::TestCase
  def setup
    @country = create_country(:alpha_2_code => 'US', :name => 'United States')
    @region = create_region(:country => @country, :abbreviation => 'CA', :name => 'California')
  end
  
  def test_should_construct_multiline_based_on_current_information
    address = Address.new
    address.street_1 = '123 Fake Street'
    assert_equal ['123 Fake Street'], address.multi_line
    
    address.street_2 = 'Apartment 456'
    expected = [
      '123 Fake Street',
      'Apartment 456'
    ]
    assert_equal expected, address.multi_line
    
    address.city = 'Somewhere'
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere'
    ]
    assert_equal expected, address.multi_line
    
    address.region = @region
    address.country = @country
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere, California',
      'United States'
    ]
    assert_equal expected, address.multi_line
    
    address.postal_code = '12345'
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere, California  12345',
      'United States'
    ]
    assert_equal expected, address.multi_line
    
    address.region = nil
    address.custom_region = 'Anywhere'
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere, Anywhere  12345',
      'United States'
    ]
    assert_equal expected, address.multi_line
    
    address.country = nil
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Somewhere, Anywhere  12345'
    ]
    assert_equal expected, address.multi_line
    
    address.city = nil
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Anywhere  12345'
    ]
    assert_equal expected, address.multi_line
    
    address.postal_code = nil
    expected = [
      '123 Fake Street',
      'Apartment 456',
      'Anywhere'
    ]
    assert_equal expected, address.multi_line
 end
  
  def test_should_construct_single_line_based_on_current_information
    address = create_address(:street_1 => '1600 Amphitheatre Parkway', :city => 'Mountain View', :region => @region, :postal_code => '94043')
    assert_equal '1600 Amphitheatre Parkway, Mountain View, California  94043, United States', address.single_line
  end
end
