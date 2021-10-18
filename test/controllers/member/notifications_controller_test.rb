require 'test_helper'

class Member::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_notifications_index_url
    assert_response :success
  end
end
