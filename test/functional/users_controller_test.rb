require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
  end

  test "should get index" do
    sign_in users(:admin)
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should show user" do
    sign_in users(:admin)
    @admin = users(:admin)
    get :show, params: {id: @admin.to_param}
    assert_response :success
  end

  test "should get edit user" do
    sign_in users(:admin)
    @admin = users(:admin)
    get :edit, params: {id: @admin.to_param}
    assert_response :success
  end

  test "should fail getting edit user" do
    sign_in users(:master_1zgm)
    @admin = users(:admin)
    get :edit, params: {id: @admin.to_param}
    assert_unauthorized
  end
end
