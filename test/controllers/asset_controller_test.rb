require "test_helper"

class AssetControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get asset_index_url
    assert_response :success
  end

  test "should get show" do
    get asset_show_url
    assert_response :success
  end

  test "should get edit" do
    get asset_edit_url
    assert_response :success
  end
end
