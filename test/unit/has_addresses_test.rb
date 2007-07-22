require "#{File.dirname(__FILE__)}/../test_helper"

class HasAddresses < Test::Unit::TestCase
  fixtures :companies, :addresses
  
  def test_should_create_one_association
    assert_equal addresses(:google_headquarters), companies(:google).headquarters_address
    assert_equal addresses(:google_sales), companies(:google).sales_address
  end
  
  def test_should_create_many_association
    assert_equal 2, companies(:google).addresses.size
    assert_equal [addresses(:google_headquarters), addresses(:google_sales)], companies(:google).addresses
  end
end
