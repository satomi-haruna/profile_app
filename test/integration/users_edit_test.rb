require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:testuser)
  end

  # 自己紹介更新が失敗するパターン、ある？
  # test "unsuccessful edit" do
  #   log_in_as(@user)
  # end

  # 自己紹介更新が成功のテスト
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    introduction = "自己紹介入力テスト！"
    patch user_path(@user), params: { user: { introduction: introduction} }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal introduction, @user.introduction
  end
end
