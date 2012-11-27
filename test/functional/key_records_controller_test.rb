require 'test_helper'

class KeyRecordsControllerTest < ActionController::TestCase
  setup do
    @key_record = key_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:key_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create key_record" do
    assert_difference('KeyRecord.count') do
      post :create, key_record: {  }
    end

    assert_redirected_to key_record_path(assigns(:key_record))
  end

  test "should show key_record" do
    get :show, id: @key_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @key_record
    assert_response :success
  end

  test "should update key_record" do
    put :update, id: @key_record, key_record: {  }
    assert_redirected_to key_record_path(assigns(:key_record))
  end

  test "should destroy key_record" do
    assert_difference('KeyRecord.count', -1) do
      delete :destroy, id: @key_record
    end

    assert_redirected_to key_records_path
  end
end
