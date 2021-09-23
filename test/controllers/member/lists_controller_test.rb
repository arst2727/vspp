require 'test_helper'

class Member::ListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get member_lists_show_url
    assert_response :success
  end

  test "should get new" do
    get member_lists_new_url
    assert_response :success
  end

  test "should get edit" do
    get member_lists_edit_url
    assert_response :success
  end
end
