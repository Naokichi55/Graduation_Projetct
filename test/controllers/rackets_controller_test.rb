require "test_helper"

class RacketsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rackets_index_url
    assert_response :success
  end
end
