require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:rakesh)
  end


  test "unsuccessful edit" do
    get edit_user_path(@user)
    patch user_path(@user), user: { name: "",
                                   email: "user@invlalid",
                                   password:              "foo",
                                   password_confirmation: "bar"}
  assert_template 'users/edit'
  end 

  test "successful edit" do 
    get edit_user_path(@user)
    patch user_path(@user), user: { name: "vineet souri",
                                   email: "vineet@example.com",
                                   password:              "",
                                   password_confirmation: ""}
  assert_not flash.empty?
  assert_redirected_to @user
  @user.reload
  assert_equal @user.name, "vineet souri"
  assert_equal @user.email, "vineet@example.com"
  end
end
