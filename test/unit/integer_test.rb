require 'test_helper'

class IntegerTest < ActiveSupport::TestCase
  
  test "overlap" do
    assert 0.methods.include? 'overlap'
    assert_equal 1, 1.overlap(4)
    assert_equal 2, 2.overlap(4)
    assert_equal 3, 3.overlap(4)
    assert_equal 4, 4.overlap(4)
    assert_equal 1, 5.overlap(4)
    assert_equal 2, 6.overlap(4)
    assert_equal 3, 7.overlap(4)
    assert_equal 4, 8.overlap(4)
    assert_equal 1, 9.overlap(4)
    # Input = 0
    assert_equal 0, 0.overlap(0)
    assert_equal 0, 0.overlap(999)
    assert_equal 0, 0.overlap(-999)
    # Overlap = 0
    assert_equal 0, 0.overlap(0)
    assert_equal 0, 999.overlap(0)
    assert_equal 0, -999.overlap(0)
  end
  
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

end
