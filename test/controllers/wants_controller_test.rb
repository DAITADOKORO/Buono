require 'test_helper'

class WantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wants_index_url
    assert_response :success
  end

  test "should get show" do
    get wants_show_url
    assert_response :success
  end

end
