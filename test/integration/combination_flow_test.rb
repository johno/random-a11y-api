require 'test_helper'

class CombinationFlowTest < ActionDispatch::IntegrationTest
  test 'GET /combos returns the latest combos' do
    first = Combo.create!(color_one: '#fff', color_two: '#444')
    most_recent = Combo.create!(color_one: '#fff', color_two: '#444')

    get '/combos'

    res = JSON.parse(response.body)
    assert res.first['id'] == most_recent.id
    assert res.length > 0
    assert_response :success
  end

  test 'GET /combos/top returns the top combos' do
    top = Combo.create!(color_one: '#fff', color_two: '#444')
    other = Combo.create!(color_one: '#fff', color_two: '#444')

    3.times do
      top.create_vote(value: true)
    end

    get '/combos/top'

    res = JSON.parse(response.body)
    assert res.first['id'] == most_recent.id
    assert res.first['votes'].length == 3
    assert_response :success
  end
end
