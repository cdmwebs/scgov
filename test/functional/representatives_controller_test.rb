require 'test_helper'

class RepresentativesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:representatives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create representative" do
    assert_difference('Representative.count') do
      post :create, :representative => { }
    end

    assert_redirected_to representative_path(assigns(:representative))
  end

  test "should show representative" do
    get :show, :id => representatives(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => representatives(:one).id
    assert_response :success
  end

  test "should update representative" do
    put :update, :id => representatives(:one).id, :representative => { }
    assert_redirected_to representative_path(assigns(:representative))
  end

  test "should destroy representative" do
    assert_difference('Representative.count', -1) do
      delete :destroy, :id => representatives(:one).id
    end

    assert_redirected_to representatives_path
  end
end
