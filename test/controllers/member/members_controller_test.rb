require 'test_helper'

class Member::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_page" do
    get member_members_my_page_url
    assert_response :success
  end

  test "should get show" do
    get member_members_show_url
    assert_response :success
  end

  test "should get timeline" do
    get member_members_timeline_url
    assert_response :success
  end

end
