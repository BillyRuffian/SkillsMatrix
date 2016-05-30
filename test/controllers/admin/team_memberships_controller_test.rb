require 'test_helper'

class Admin::TeamMembershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_team_memberships_index_url
    assert_response :success
  end

end
