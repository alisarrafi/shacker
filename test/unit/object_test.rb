require 'test_helper'

class ObjectTest < ActiveSupport::TestCase
  
  # Generate debugging chunk output
  def debug_chunk
    characters = ['a', 'b', 'c', 'd', 'e']
    lengths = [1, 2, 3, 4]
    lengths.each do |length|
      1.upto(characters_preset.size ** length) do |offset|
        chunk({:offset => offset, :length => length, :characters => characters })
        RAILS_DEFAULT_LOGGER.debug ""
      end
    end
  end
  
  # Generate debugging offset output
  def debug_offset
    0.upto(200) do |p|
      offset({ :space => 100, :position => p })
    end
  end
  
  test "to_positive_i" do
    assert 0.methods.include? 'to_positive_i'
    assert_equal 100, -100.to_positive_i
    assert_equal 1, 0.to_positive_i
    assert_equal 100, 100.to_positive_i
  end

  test "chunk" do
    assert Object.methods.include? 'chunk'
    # Length 1
    characters = ['a', 'b', 'c']
    assert_equal 'a', chunk({:offset => 1, :length => 1, :characters => characters })
    assert_equal 'b', chunk({:offset => 2, :length => 1, :characters => characters })
    assert_equal 'c', chunk({:offset => 3, :length => 1, :characters => characters })
    assert_equal 'a', chunk({:offset => 4, :length => 1, :characters => characters })
    assert_equal 'b', chunk({:offset => 5, :length => 1, :characters => characters })
    assert_equal 'c', chunk({:offset => 6, :length => 1, :characters => characters })
    assert_equal 'a', chunk({:offset => 7, :length => 1, :characters => characters })
    assert_equal 'b', chunk({:offset => 8, :length => 1, :characters => characters })
    assert_equal 'c', chunk({:offset => 9, :length => 1, :characters => characters })
    # Length 2
    assert_equal 'aa', chunk({:offset => 1, :length => 2, :characters => characters })
    assert_equal 'ab', chunk({:offset => 2, :length => 2, :characters => characters })
    assert_equal 'ac', chunk({:offset => 3, :length => 2, :characters => characters })
    assert_equal 'ba', chunk({:offset => 4, :length => 2, :characters => characters })
    assert_equal 'bb', chunk({:offset => 5, :length => 2, :characters => characters })
    assert_equal 'bc', chunk({:offset => 6, :length => 2, :characters => characters })
    assert_equal 'ca', chunk({:offset => 7, :length => 2, :characters => characters })
    assert_equal 'cb', chunk({:offset => 8, :length => 2, :characters => characters })
    assert_equal 'cc', chunk({:offset => 9, :length => 2, :characters => characters })
    # Random length
    characters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']  
    1.upto(20) do |length|
      assert_equal (characters.first * length), chunk({:offset => 1, :length => length, :characters => characters })
      assert_equal (characters.last * length), chunk({:offset => characters.size ** length, :length => length, :characters => characters })
    end
  end
  
  test "identify" do
    characters = ['a', 'b', 'c', 'd', 'e']
    margins = [1, 2, 4, 8, 99, 128, 512]
    lengths = [1, 2, 3, 4]
    num_chars = characters.size
    lengths.each do |length|
      margins.each do |margin|
        expected = 1
        1.upto(num_chars ** length) do |offset|
          #RAILS_DEFAULT_LOGGER.debug "offset: #{offset}, margin: #{margin} expected: #{expected} (#{characters[expected - 1]})"
          assert_equal characters[expected - 1], identify({ :offset => offset, :margin => margin, :characters => characters })
          expected += 1 if offset.multiple_of?(margin)
          expected = expected.overlap num_chars
        end
      end
    end
  end

  test "offset" do
    assert 0.methods.include? 'offset'
    # Space <= 1
    assert_equal 1, offset({ :space => -1 })
    assert_equal 1, offset({ :space => -1, :position => -1 })
    assert_equal 1, offset({ :space => -1, :position => 0 })
    assert_equal 1, offset({ :space => -1, :position => 1 })
    assert_equal 1, offset({ :space => -1, :position => 1000 })
    assert_equal 1, offset({ :space => 0 })
    assert_equal 1, offset({ :space => 0, :position => -1 })
    assert_equal 1, offset({ :space => 0, :position => 0 })
    assert_equal 1, offset({ :space => 0, :position => 1 })
    assert_equal 1, offset({ :space => 0, :position => 1000 })
    assert_equal 1, offset({ :space => 1 })
    assert_equal 1, offset({ :space => 1, :position => -1 })
    assert_equal 1, offset({ :space => 1, :position => 0 })
    assert_equal 1, offset({ :space => 1, :position => 1 })
    assert_equal 1, offset({ :space => 1, :position => 1000 })
    # Offset <= 1
    assert_equal 1, offset({ :space => -1 })
    assert_equal 1, offset({ :space => 2 })
    assert_equal 1, offset({ :space => 3 })
    assert_equal 1, offset({ :space => 4 })
    assert_equal 1, offset({ :space => 1000 })
    assert_equal 1, offset({ :space => 1000, :position => -1 })
    assert_equal 1, offset({ :space => 1000, :position => 0 })
    assert_equal 1, offset({ :space => 1000, :position => 1 })
    # Space <= 3
    assert_equal 1, offset({ :space => 2, :position => 3 })
    assert_equal 1, offset({ :space => 3, :position => 4 })
    # Space < offset
    assert_equal 1, offset({ :space => 99, :position => 100 })
    assert_equal offset({ :space => 99, :position => 2 }), offset({ :space => 99, :position => 101 })
    assert_equal offset({ :space => 99, :position => 3 }), offset({ :space => 99, :position => 102 })
    assert_equal offset({ :space => 99, :position => 4 }), offset({ :space => 99, :position => 103 })
    assert_equal offset({ :space => 99, :position => 5 }), offset({ :space => 99, :position => 104 })
    assert_equal offset({ :space => 99, :position => 6 }), offset({ :space => 99, :position => 105 })
    # Example 100
    assert_equal 50, offset({ :space => 100, :position => 2 })
    assert_equal 26, offset({ :space => 100, :position => 3 })
    assert_equal 75, offset({ :space => 100, :position => 4 })
    assert_equal 20, offset({ :space => 100, :position => 5 })
    assert_equal 40, offset({ :space => 100, :position => 6 })
    assert_equal 60, offset({ :space => 100, :position => 7 })
    assert_equal 80, offset({ :space => 100, :position => 8 })
    assert_equal 35, offset({ :space => 100, :position => 99 })
  end
  
end