require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:testuser)
    @other_user = users(:testother)
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # updateの際、loginしてないとridirect emailの更新ないけどどうしよう?
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  # emailの更新ないけど一旦これで?
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
