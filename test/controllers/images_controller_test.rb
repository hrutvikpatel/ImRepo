require "test_helper"

class ImageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get image_index_url
    assert_response :success
  end

  test "should get show" do
    get image_show_url
    assert_response :success
  end
end
