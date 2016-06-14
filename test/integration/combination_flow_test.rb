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

    get '/combos?per_page=1&page=2'
    res = JSON.parse(response.body)
    assert res.length == 1
    assert res.first['id'] == first.id
  end

  test 'GET /combos?hex=444444 returns the latest combos' do
    one = Combo.create!(color_one: '#fff', color_two: '#444444')
    zero = Combo.create!(color_one: '#aabbcc', color_two: '#444444')
    not_included = Combo.create!(color_one: '#111111', color_two: '#ffffff')

    get '/combos?hex=444444'

    res = JSON.parse(response.body)
    assert res[0]['id'] == zero.id
    assert res[1]['id'] == one.id
    assert res.length == 2
    assert_response :success
  end

  test 'GET /combos/top returns the top combos' do
    top = Combo.create!(color_one: '#fff', color_two: '#444')
    other = Combo.create!(color_one: '#fff', color_two: '#444')

    3.times do
      top.votes.create(value: true)
    end

    4.times do
      other.votes.create(value: false)
    end

    other.votes.create(value: true)

    get '/combos/top'

    res = JSON.parse(response.body)
    assert res.first['id'] == top.id
    assert res.first['votes'].length == 3
    assert_response :success
  end
end
