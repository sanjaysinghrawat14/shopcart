require "test_helper"

class UserFeedbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_feedbacks_new_url
    assert_response :success
  end
end
