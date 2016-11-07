require 'test_helper'

class TimetrackerControllerTest < ActionDispatch::IntegrationTest
  test "should get late" do
    get timetracker_late_url
    assert_response :success
  end

end
