require "#{File.dirname(__FILE__)}/../test_helper"

class RegionByDefaultTest < Test::Unit::TestCase
  def setup
    @region = Region.new
  end
  
  def test_should_not_have_an_id
    assert_nil @region.id
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
    region = Region.new(:country => 'US', :abbreviation => 'CA')
    assert_equal 'US-CA', region.code
  end
  
  def test_should_use_country_and_abbreviation_for_code_if_specified
    region = Region.new(:country => 'US', :abbreviation => 'CA', :code => 'US--CA')
    assert_equal 'US-CA', region.code
  end
end

class RegionTest < Test::Unit::TestCase
  def test_should_be_valid_with_a_set_of_valid_attributes
    region = new_region
    assert region.valid?
  end
  
  def test_should_require_an_id
    region = new_region(:id => nil)
    assert !region.valid?
    assert_equal 1, Array(region.errors.on(:id)).size
  end
  
  def test_should_require_a_code
    region = new_region
    region.code = nil
    assert !region.valid?
    assert_equal 1, Array(region.errors.on(:code)).size
  end
  
  def test_should_require_a_unique_code
    region = new_region
    region.code = 'US-CA'
    assert !region.valid?
    assert_equal 1, Array(region.errors.on(:code)).size
  end
  
  def test_should_require_a_name
    region = new_region(:name => nil)
    assert !region.valid?
    assert_equal 1, Array(region.errors.on(:name)).size
  end
  
  def test_should_require_a_country
    region = new_region(:country => nil)
    assert !region.valid?
    assert_equal 1, Array(region.errors.on(:country_id)).size
  end
  
  def test_should_require_an_abbreviation
    region = new_region(:abbreviation => nil)
    assert !region.valid?
    assert_equal 2, Array(region.errors.on(:abbreviation)).size
  end
  
  def test_should_not_allow_abbrevations_shorter_than_1_or_longer_than_5_characters
    region = new_region(:abbreviation => '')
    assert !region.valid?
    assert_equal 2, Array(region.errors.on(:abbreviation)).size
    
    region.abbreviation += 'a'
    assert region.valid?
    
    region.abbreviation += 'aaaa'
    assert region.valid?
    
    region.abbreviation += 'a'
    assert !region.valid?
    assert_equal 1, Array(region.errors.on(:abbreviation)).size
  end
  
  def test_should_not_require_a_group
    region = new_region(:group => nil)
    assert region.valid?
  end
  
  def test_should_use_code_for_stringification
    region = new_region(:country => 'US', :abbreviation => 'NS')
    assert_equal 'US-NS', region.to_s
  end
end

class RegionAfterBeingCreatedTest < Test::Unit::TestCase
  def setup
    @region = Region['US-CA']
  end
  
  def test_should_belong_to_a_country
    assert_equal Country['US'], @region.country
  end
  
  def test_should_not_have_any_addresses
    assert_equal 0, @region.addresses.size
  end
end

class RegionWithAddressesTest < Test::Unit::TestCase
  def setup
    @region = Region['US-CA']
    @address = create_address(:region => @region)
  end
  
  def test_should_have_many_addresses
    assert_equal [@address], @region.addresses
  end
end
