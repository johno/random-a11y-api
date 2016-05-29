require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'is invalid without a combo' do
    assert Vote.new.invalid?
  end

  test 'is valid with a combo' do
    assert Vote.new(combo: Combo.new).valid?
  end
end
