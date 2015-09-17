$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "numeric"
require "test/unit"

class TestNumeric < Test::Unit::TestCase
  
  
  def test_to_letter
    assert_equal("A", 0.to_letter )
    assert_equal("B", 1.to_letter )
    assert_equal("C", 2.to_letter )
    assert_equal("", 3.to_letter )
    assert_equal("", 4.to_letter )
  end
end