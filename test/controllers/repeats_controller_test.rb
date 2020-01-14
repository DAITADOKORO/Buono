require 'test_helper'

class RepeatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get repeats_index_url
    assert_response :success
  end

  test "should get show" do
    get repeats_show_url
    assert_response :success
  end

end
