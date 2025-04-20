require "test_helper"

class RacketsPostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rackets_post_index_url
    assert_response :success
  end
end
