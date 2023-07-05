require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Test User", email: "user@test.com",
                     introduction: "テストだよ！",
                     password: "testpw", password_confirmation: "testpw")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # 存在するか
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  # emailのフォーマットが正しいと判断されるか
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@test.com USER@example.COM A_US-ER@test.test.org
                         first.last@test.jp aiueo+pop@ppp.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # emailのフォーマットが間違っていると判断されるか
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@test,com user_at_aiueo.org user.name@example.
                           aiueo@ppp_bbb.com aiueo@ppp+bbb.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # emailが一意か
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  # パスワードが空白はダメ
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  # パスワードの長さが5以下はダメ
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
