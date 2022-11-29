require "application_system_test_case"

class Order2sTest < ApplicationSystemTestCase
  setup do
    @order2 = order2s(:one)
  end

  test "visiting the index" do
    visit order2s_url
    assert_selector "h1", text: "Order2s"
  end

  test "should create order2" do
    visit order2s_url
    click_on "New order2"

    fill_in "Card expires on", with: @order2.card_expires_on
    fill_in "Card type", with: @order2.card_type
    fill_in "Cart", with: @order2.cart_id
    fill_in "First name", with: @order2.first_name
    fill_in "Ip address", with: @order2.ip_address
    fill_in "Last name", with: @order2.last_name
    fill_in "New", with: @order2.new
    click_on "Create Order2"

    assert_text "Order2 was successfully created"
    click_on "Back"
  end

  test "should update Order2" do
    visit order2_url(@order2)
    click_on "Edit this order2", match: :first

    fill_in "Card expires on", with: @order2.card_expires_on
    fill_in "Card type", with: @order2.card_type
    fill_in "Cart", with: @order2.cart_id
    fill_in "First name", with: @order2.first_name
    fill_in "Ip address", with: @order2.ip_address
    fill_in "Last name", with: @order2.last_name
    fill_in "New", with: @order2.new
    click_on "Update Order2"

    assert_text "Order2 was successfully updated"
    click_on "Back"
  end

  test "should destroy Order2" do
    visit order2_url(@order2)
    click_on "Destroy this order2", match: :first

    assert_text "Order2 was successfully destroyed"
  end
end
