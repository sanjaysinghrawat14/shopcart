require "test_helper"

class Order2sControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order2 = order2s(:one)
  end

  test "should get index" do
    get order2s_url
    assert_response :success
  end

  test "should get new" do
    get new_order2_url
    assert_response :success
  end

  test "should create order2" do
    assert_difference("Order2.count") do
      post order2s_url, params: { order2: { card_expires_on: @order2.card_expires_on, card_type: @order2.card_type, cart_id: @order2.cart_id, first_name: @order2.first_name, ip_address: @order2.ip_address, last_name: @order2.last_name, new: @order2.new } }
    end

    assert_redirected_to order2_url(Order2.last)
  end

  test "should show order2" do
    get order2_url(@order2)
    assert_response :success
  end

  test "should get edit" do
    get edit_order2_url(@order2)
    assert_response :success
  end

  test "should update order2" do
    patch order2_url(@order2), params: { order2: { card_expires_on: @order2.card_expires_on, card_type: @order2.card_type, cart_id: @order2.cart_id, first_name: @order2.first_name, ip_address: @order2.ip_address, last_name: @order2.last_name, new: @order2.new } }
    assert_redirected_to order2_url(@order2)
  end

  test "should destroy order2" do
    assert_difference("Order2.count", -1) do
      delete order2_url(@order2)
    end

    assert_redirected_to order2s_url
  end
end
