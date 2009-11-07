require 'test_helper'

class FixnumTest < ActiveSupport::TestCase

  test "max_in_row" do
    assert 0.methods.include? 'max_in_row'
    assert_equal 0, -1.max_in_row
    assert_equal 0, 0.max_in_row
    assert_equal 2, 1.max_in_row
    assert_equal 2, 2.max_in_row
    assert_equal 4, 3.max_in_row
    assert_equal 4, 4.max_in_row
    assert_equal 8, 5.max_in_row
    assert_equal 8, 6.max_in_row
    assert_equal 8, 8.max_in_row
    assert_equal 16, 9.max_in_row
    assert_equal 16, 16.max_in_row
    assert_equal 32, 17.max_in_row
  end
  
  test "positions_in_row" do
    assert 0.methods.include? 'positions_in_row'
    assert_equal 0, -1.positions_in_row
    assert_equal 0, 0.positions_in_row
    assert_equal 2, 1.positions_in_row
    assert_equal 2, 2.positions_in_row
    assert_equal 2, 3.positions_in_row
    assert_equal 2, 4.positions_in_row
    assert_equal 4, 5.positions_in_row
    assert_equal 4, 8.positions_in_row
    assert_equal 8, 9.positions_in_row
    assert_equal 64, 128.positions_in_row
  end
  
  test "offset" do
    assert 0.methods.include? 'offset'
    # Size <= 1
    assert_equal 0, -1.offset
    assert_equal 0, -1.offset(-1)
    assert_equal 0, -1.offset(0)
    assert_equal 0, -1.offset(1)
    assert_equal 0, -1.offset(1000)
    assert_equal 0, 0.offset
    assert_equal 0, 0.offset(-1)
    assert_equal 0, 0.offset(0)
    assert_equal 0, 0.offset(1)
    assert_equal 0, 0.offset(1000)
    assert_equal 0, 1.offset
    assert_equal 0, 1.offset(-1)
    assert_equal 0, 1.offset(0)
    assert_equal 0, 1.offset(1)
    assert_equal 0, 1.offset(1000)
    # Offset <= 1
    assert_equal 0, 2.offset
    assert_equal 0, 3.offset
    assert_equal 0, 4.offset
    assert_equal 0, 1000.offset
    assert_equal 0, 1000.offset(-1)
    assert_equal 0, 1000.offset(0)
    assert_equal 0, 1000.offset(1)
    # Size < offset
    assert_equal 0, 0.offset(1)
    assert_equal 0, 2.offset(3)
    assert_equal 0, 3.offset(4)
    assert_equal 0, 5000.offset(5001)
    # Size <= 3
    assert_equal 0, 2.offset(1)
    assert_equal 1, 2.offset(2)
    assert_equal 0, 3.offset(1)
    assert_equal 1, 3.offset(2)
    assert_equal 2, 3.offset(3)
    # Example 100
    assert_equal 0, 100.offset(1)
    assert_equal 51, 100.offset(2)
    assert_equal 26, 100.offset(3)
    assert_equal 75, 100.offset(4)
    assert_equal 25, 100.offset(5)
    assert_equal 50, 100.offset(6)
    assert_equal 75, 100.offset(7)
    assert_equal 100, 100.offset(8)
    assert_equal 12, 100.offset(9)
    assert_equal 96, 100.offset(16)
    # Example 1000
    assert_equal 0, 1000.offset(1)
    assert_equal 501, 1000.offset(2)
    assert_equal 251, 1000.offset(3)
    assert_equal 750, 1000.offset(4)
    assert_equal 250, 1000.offset(5)
    assert_equal 500, 1000.offset(6)
    assert_equal 750, 1000.offset(7)
    assert_equal 1000, 1000.offset(8)
    assert_equal 125, 1000.offset(9)
    assert_equal 1000, 1000.offset(16)
    # Example 777
    assert_equal 0, 777.offset(1)
    assert_equal 388, 777.offset(2)
    assert_equal 195, 777.offset(3)
    assert_equal 584, 777.offset(4)
    assert_equal 194, 777.offset(5)
    assert_equal 388, 777.offset(6)
    assert_equal 582, 777.offset(7)
    assert_equal 776, 777.offset(8)
    assert_equal 97, 777.offset(9)
    assert_equal 776, 777.offset(16)
  end

end
