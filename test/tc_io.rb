$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "numeric"
require "io"
require "test/unit"

class TestIo < Test::Unit::TestCase
  
  
  def test_print_screen
    arr = [[true,true,true],[true,true,false],[true,true,false]]
    printed_screen = "  1   2   3  \nA x | x | x\n --- --- ---\nB x | x | o\n --- --- ---\nC x | x | o\n"
    assert_equal(printed_screen, Io.new.print_screen(arr) )
  end

  def test_empty_print_screen
    arr = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
    printed_screen = "  1   2   3  \nA   |   |  \n --- --- ---\nB   |   |  \n --- --- ---\nC   |   |  \n"
    assert_equal(printed_screen, Io.new.print_screen(arr) )
  end
end