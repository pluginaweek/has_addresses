require "#{File.dirname(__FILE__)}/../test_helper"

class RegionByDefaultTest < Test::Unit::TestCase
  def setup
    @region = Region.new
  end
  
  def test_should_not_have_a_name
    assert_nil @region.name
  end
  
  def test_should_not_have_a_country
    assert_nil @region.country_id
  end
  
  def test_should_not_have_an_abbreviation
    assert_nil @region.abbreviation
  end
end

class RegionTest < Test::Unit::TestCase
  def test_should_be_valid_with_a_set_of_valid_attributes
    region = new_region
    assert region.valid?
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
  
  def test_should_use_name_for_stringification
    region = new_region(:name => 'California')
    assert_equal 'California', region.to_s
  end
end

class RegionAfterBeingCreatedTest < Test::Unit::TestCase
  def setup
    @region = Region['California']
  end
  
  def test_should_belong_to_a_country
    assert_equal Country['United States'], @region.country
  end
  
  def test_should_not_have_any_addresses
    assert_equal 0, @region.addresses.size
  end
end

class RegionWithAddressesTest < Test::Unit::TestCase
  def setup
    @region = Region['California']
    @address = create_address(:region => @region)
  end
  
  def test_should_have_many_addresses
    assert_equal [@address], @region.addresses
  end
end
