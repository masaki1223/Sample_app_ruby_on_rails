require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user=users(:michael)
    @another_user=users(:archer)
    end

    test "unsuccessful edit" do
      log_in_as(@user)
      get edit_user_path(@user)
      assert_template 'users/edit'
      patch user_path(@user),params:{ user:{ name:"",
                                  email:"foo@invalid",
                                  password:"foo",
                                  password_confirmation:"bar" }}

      assert_template 'users/edit'
      assert_select "div.alert", "The form contains 4 errors."
      end

      test "successful edit with friendly forwarding" do
        get edit_user_path(@user)
        assert session[:forwarding_url]
        log_in_as(@user)
        assert_redirected_to edit_user_url(@user)
        patch user_path(@user),params:{ user:{ name:"John",
                                        email:"john@example.com",
                                        password:"",
                                        password_confirmation:"" }}
        assert_not flash.empty?
        assert_redirected_to @user
        @user.reload
        assert_equal "John", @user.name
        assert_equal "john@example.com", @user.email
      end

      test "should redirect edit when not logged in" do
        get edit_user_path(@user)
        assert_not flash.empty?#flash has "Please log in" because it's not logged in
        #this returns false
        assert_redirected_to login_url
      end

      test "should redirect update when not logged in" do
        patch user_path(@user),params:{ user:{ name:@user.name,
                                    email:@user.email }}
        assert_not flash.empty?
        assert_redirected_to login_url
      end

      test "should redirect edit when logged in as a wrong user" do
        log_in_as(@another_user)
        get edit_user_path(@user),params:{ user:{ name:@user.name,
                                          email:@user.email }}
        assert_not flash.empty?
        assert_redirected_to root_url
      end



end