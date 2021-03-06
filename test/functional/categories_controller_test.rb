require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:admin)
    @category = categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "index should have selecting years" do
    get :index
    years = Category.get_all_years()
    years.each do |year|
      assert_select "select option[value='#{year}']"
    end
  end

  test "selected criteria should stay selected" do
    get :index, params: {year: 2012}
    assert_select "select[name='year'] option[selected][value='2012']"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, params: {category: @category.attributes}
    end

    assert_redirected_to categories_path
  end

  test "should show category" do
    get :show, params: {id: @category.to_param}
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {id: @category.to_param}
    assert_response :success
  end

  test "should update category" do
    put :update, params: {id: @category.to_param, category: @category.attributes}
    assert_redirected_to categories_path
  end

  test "should destroy not used category" do
    category = categories(:not_used)

    assert_difference('Category.count', -1) do
      delete :destroy, params: {id: category.to_param}
    end

    assert_redirected_to categories_path
  end

  test "should not destroy used category" do
    category = categories(:five)

    assert_difference('Category.count', 0) do
      delete :destroy, params: {id: category.to_param}
    end

    assert_redirected_to categories_path
  end
end
