require "#{File.dirname(__FILE__)}/../test_helper"

class RegionByDefaultTest < ActiveRecord::TestCase
  def setup
    @region = Region.new
  end
  
  def test_should_not_have_a_country
    assert_nil @region.country_id
  end
  
  def test_should_not_have_a_group
    assert_nil @region.group
  end
  
  def test_should_not_have_a_name
    assert_nil @region.name
  end
  
  def test_should_not_have_an_abbreviation
    assert_nil @region.abbreviation
  end
  
  def test_should_use_id_for_abbreviation_if_not_specified
    region = Region.new(:id => 1005)
    assert_equal '005', region.abbreviation
    
    region = Region.new(:id => 1052)
    assert_equal '052', region.abbreviation
    
    region = Region.new(:id => 1523)
    assert_equal '523', region.abbreviation
    
    region = Region.new(:id => 15234)
    assert_equal '234', region.abbreviation
  end
  
  def test_should_not_use_id_for_abbreviation_if_specified
    region = Region.new(:id => 1005, :abbreviation => 'CA')
    assert_equal 'CA', region.abbreviation
  end
  
  def test_should_use_country_and_abbreviation_for_code_if_not_specified
    region = Region.new(:country => create_country(:alpha_2_code => 'US'), :abbreviation => 'CA')
    assert_equal 'US-CA', region.code
  end
  
  def test_should_use_country_and_abbreviation_for_code_if_specified
    region = Region.new(:country => create_country(:alpha_2_code => 'US'), :abbreviation => 'CA', :code => 'US--CA')
    assert_equal 'US-CA', region.code
  end
end

class RegionTest < ActiveRecord::TestCase
  def test_should_be_valid_with_a_set_of_valid_attributes
    region = new_region
    assert region.valid?
  end
  
  def test_should_require_a_code
    region = new_region
    region.code = nil
    assert !region.valid?
    assert region.errors.invalid?(:code)
  end
  
  def test_should_require_a_unique_code
    country = create_country
    
    region = new_region(:country => country)
    region.code = 'US-CA'
    region.save!
    
    region = new_region(:country => country)
    region.code = 'US-CA'
    assert !region.valid?
    assert region.errors.invalid?(:code)
  end
  
  def test_should_require_a_name
    region = new_region(:name => nil)
    assert !region.valid?
    assert region.errors.invalid?(:name)
  end
  
  def test_should_require_a_country
    region = new_region(:country => nil)
    assert !region.valid?
    assert region.errors.invalid?(:country_id)
  end
  
  def test_should_require_an_abbreviation
    region = new_region(:abbreviation => nil)
    assert !region.valid?
    assert region.errors.invalid?(:abbreviation)
  end
  
  def test_should_not_allow_abbrevations_shorter_than_1_or_longer_than_5_characters
    region = new_region(:abbreviation => '')
    assert !region.valid?
    assert region.errors.invalid?(:abbreviation)
    
    region.abbreviation += 'a'
    assert region.valid?
    
    region.abbreviation += 'aaaa'
    assert region.valid?
    
    region.abbreviation += 'a'
    assert !region.valid?
    assert region.errors.invalid?(:abbreviation)
  end
  
  def test_should_not_require_a_group
    region = new_region(:group => nil)
    assert region.valid?
  end
  
  def test_should_use_code_for_stringification
    region = new_region(:country => create_country(:alpha_2_code => 'US'), :abbreviation => 'CA')
    assert_equal 'US-CA', region.to_s
  end
end

class RegionAfterBeingCreatedTest < ActiveRecord::TestCase
  def setup
    @region = create_region
  end
  
  def test_should_not_have_any_addresses
    assert_equal 0, @region.addresses.size
  end
end

class RegionWithAddressesTest < ActiveRecord::TestCase
  def setup
    @region = create_region
    @address = create_address(:region => @region)
  end
  
  def test_should_have_addresses
    assert_equal [@address], @region.addresses
  end
end
