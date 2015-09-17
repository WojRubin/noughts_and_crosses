$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "string"
require "test/unit"

class TestString < Test::Unit::TestCase
  
  
  def test_to_number
    assert_equal(0, "a".to_number )
    assert_equal(1, "b".to_number )
    assert_equal(2, "c".to_number )
    assert_equal(0, "A".to_number )
    assert_equal(1, "B".to_number )
    assert_equal(2, "C".to_number )
    assert_equal("", "ddfsfs".to_number )
  end
end