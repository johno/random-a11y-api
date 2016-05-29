require 'test_helper'

class ComboTest < ActiveSupport::TestCase
  test 'invalid hex colors' do
    assert Combo.new(color_one: '', color_two: '#ggghhh').invalid?
  end

  test 'valid hex colors' do
    assert Combo.new(color_one: '#123456', color_two: '#fff').valid?
  end
end
