require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user=users(:michael)
    @another_user=users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be editted via web" do
    log_in_as @another_user
    assert_not @another_user.admin?
    patch user_path(@another_user), params:{
                                user:{ password:"",
                                      password_confirmation:"",
                                      admin:true } }
    assert_not @another_user.reload.admin?
  end

  test "should redirect destroy to login url when not logged in" do
    assert_no_difference'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as (@another_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
    end
end
