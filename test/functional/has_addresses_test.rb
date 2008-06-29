require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CompanyByDefaultTest < Test::Unit::TestCase
  def setup
    @company = create_company
  end
  
  def test_should_not_have_any_addresses
    assert @company.addresses.empty?
  end
end

class CompanyWithAddressesTest < Test::Unit::TestCase
  def setup
    @company = create_company
    @address = create_address(:addressable => @company)
  end
  
  def test_should_have_addresses
    assert_equal [@address], @company.addresses
  end
end
