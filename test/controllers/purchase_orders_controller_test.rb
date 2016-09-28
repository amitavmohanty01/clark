require 'test_helper'

class PurchaseOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase_order = purchase_orders(:one)
  end

  test "should get index" do
    get purchase_orders_url, env: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(users(:first_user).name, 'password')}
    assert_response :success
  end

  test "should create purchase_order" do
    # This test behaviour is expected after fixtures are loaded into test database. If fixtures are not loaded, the constraint violation exception
    # will not be triggerred.
    assert_raises(Exception) do
      post purchase_orders_url, params: { purchase_order: { store_id: @purchase_order.store_id } }, env: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(users(:first_user).name, 'password')}
    end
  end

  test "should show purchase_order" do
    get purchase_order_url(@purchase_order), env: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(users(:first_user).name, 'password')}
    assert_response :success
  end

  test "should update purchase_order" do
    patch purchase_order_url(@purchase_order), params: { purchase_order: { store_id: @purchase_order.store_id } }, env: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(users(:first_user).name, 'password')}
  end

  test "should destroy purchase_order" do
    assert_difference('PurchaseOrder.count', -1) do
      delete purchase_order_url(@purchase_order), env: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(users(:first_user).name, 'password')}
    end
  end
end
