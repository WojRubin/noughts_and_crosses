$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "validator"
require "test/unit"

class TestValidator < Test::Unit::TestCase

  def test_pass_validate_move
    move_string = "a1"
    assert_equal(move_string, Validator.new.move( move_string ))
  end

  def test_false_validate_move
    move_string = "a6"
    assert_equal(false, Validator.new.move( move_string ))
  end

  def test_pass_validate_gamer_symbol
    gamer_symbol_string = 'o'
    assert_equal(gamer_symbol_string, Validator.new.gamer_symbol( gamer_symbol_string ))
  end

  def test_false_validate_gamer_symbol
    gamer_symbol_string = "a"
    assert_equal(false, Validator.new.gamer_symbol( gamer_symbol_string ))
  end
end