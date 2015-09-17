$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "string"
require "matrix"
require "test/unit"

class TestMatrix < Test::Unit::TestCase
  
  
  def test_get_blocking_move1
    arr = [[ nil,nil,nil],
           [nil,nil,nil],
          [true,true,nil]]
    assert_equal([2,2], Matrix.new(arr, 'x').get_blocking_move )
  end

  def test_get_blocking_move2
    arr = [[ true,nil,nil],
           [ true,nil,nil],
           [nil,nil,nil]]
    assert_equal([2,0], Matrix.new(arr, 'x').get_blocking_move )
  end

  def test_get_blocking_move_false
    arr = [[ nil,nil,nil],
           [nil,nil,nil],
          [true,true,true]]
    assert_equal(false, Matrix.new(arr, 'x').get_blocking_move )
  end

  def test_is_free_move
    arr = [[ true,false,true],
           [false,true,false],
          [true,true,true]]
    assert_equal(false, Matrix.new(arr, 'x').is_free_move? )
  end

  def test_add_computer_move
    arr_before = [[ nil,nil,nil],
           [nil,nil,nil],
          [nil,nil,nil]]
    arr_after = [[ false ,nil,nil],
                [nil,nil,nil],
                [nil,nil,nil]]
    assert_equal(arr_after , Matrix.new(arr_before, 'x').add_move([0,0],'computer') )
  end

  def test_add_user_move
    arr_before = [[ nil,nil,nil],
           [nil,nil,nil],
          [nil,nil,nil]]
    arr_after = [[ true ,nil,nil],
                [nil,nil,nil],
                [nil,nil,nil]]
    assert_equal(arr_after , Matrix.new(arr_before, 'x').add_user_move('a1'))
  end

  def test_is_free_move?
        arr = [[ true,false,true],
           [false,true,false],
          [true,true,true]]
      assert_equal(false, Matrix.new(arr, 'x').is_free_move? )
  end

  def test_pass_is_free_field?
    arr = [[ nil,false,nil],
           [false,nil,false],
          [nil,true,true]]
    assert_equal(true, Matrix.new(arr, 'x').is_free_field?('a1') )
  end
  def test_false_is_free_field?
    arr = [[ nil,false,nil],
           [false,nil,false],
          [nil,true,true]]
    assert_equal(false, Matrix.new(arr, 'x').is_free_field?('a2') )
  end

  def test_get_best_move
    arr = [[false,false,false],
           [false,nil,false],
          [true,true,true]]
    assert_equal([1,1], Matrix.new(arr, 'x').get_best_move )
  end

   def test_get_best_move
    arr = [[ nil,nil,false],
           [false,true,false],
          [false,nil,true]]
    assert_equal([0,0], Matrix.new(arr, 'x').get_best_move )
  end
end