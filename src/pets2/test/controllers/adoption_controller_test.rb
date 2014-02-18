require 'test_helper'

class AdoptionControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
	assert_select '#columns #side a', minimum: 2
	assert_select '#main .entry', 1
	assert_select 'h3', 'Marcelle'
  end

  test "markup needed for adoption.js.coffee is in place" do
    get :index
    assert_select '.adoption .entry > img', 1
    assert_select '.entry input[type=submit]', 2
  end
end
