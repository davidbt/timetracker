require 'test_helper'

class TimetrackerControllerTest < ActionDispatch::IntegrationTest
  test "need authentication" do
    for url in [timetracker_late_url, timetracker_review_url] do
      get url
      assert_response :redirect
      assert_redirected_to user_session_url
    end
  end

  test "get late" do
    sign_in users(:user1)
    get timetracker_late_url
    assert_response :success
    names = ["Alan Turing", "Juan Perez", "Alan Turing"]
    assert_select "#late-table tbody tr" do |elements|
      elements.each_with_index do |element, index|
        assert_select element, "td", names[index]
      end
    end
  end
end
