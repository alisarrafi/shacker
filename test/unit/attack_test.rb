require 'test_helper'

class AttackTest < ActiveSupport::TestCase

  def setup
    Attack.delete_all
  end

  test "in_progress?" do
    assert_equal false, Attack.in_progress?
    Attack.create!
    assert Attack.in_progress?.is_a? Attack
  end



end