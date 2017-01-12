require 'test_helper'

class TimetrackerControllerTest < ActionDispatch::IntegrationTest
  test "need authentication" do
    for url in [timetracker_late_url, timetracker_review_url] do
      get url
      assert_response :redirect
      assert_redirected_to user_session_url
    end
  end
end
