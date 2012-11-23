require 'test_helper'

class KeyFieldsControllerTest < ActionController::TestCase
  setup do
    @key_field = key_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:key_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create key_field" do
    assert_difference('KeyField.count') do
      post :create, key_field: {  }
    end

    assert_redirected_to key_field_path(assigns(:key_field))
  end

  test "should show key_field" do
    get :show, id: @key_field
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @key_field
    assert_response :success
  end

  test "should update key_field" do
    put :update, id: @key_field, key_field: {  }
    assert_redirected_to key_field_path(assigns(:key_field))
  end

  test "should destroy key_field" do
    assert_difference('KeyField.count', -1) do
      delete :destroy, id: @key_field
    end

    assert_redirected_to key_fields_path
  end
end
