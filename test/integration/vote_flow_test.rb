require 'test_helper'

class VoteFlowTest < ActionDispatch::IntegrationTest
  test 'POST /votes with valid data' do
    post '/votes', params: {
      vote: {
        value: true
      },
      combo: [
        '#111',
        '#fafafa'
      ]
    }

    combo = Combo.last
    assert combo.color_one == '#111'
    assert combo.color_two == '#fafafa'
    assert combo.votes.last.value
    assert_response :success
  end

  test 'POST /votes with invalid data' do
    post '/votes', params: {
      vote: {
        value: true
      },
      combo: [
        'foo'
      ]
    }

    assert_response :unprocessable_entity
  end
end
