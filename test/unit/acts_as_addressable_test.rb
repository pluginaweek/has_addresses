require "#{File.dirname(__FILE__)}/../test_helper"

class ActsAsAddressableTest < Test::Unit::TestCase
  fixtures :credit_cards, :addresses
  
  def test_credit_card_address
    assert_equal addresses(:known_region), credit_cards(:known_region).address
  end
end
