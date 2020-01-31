require 'test_helper'

class RemindListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get remind_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get remind_lists_show_url
    assert_response :success
  end

end
