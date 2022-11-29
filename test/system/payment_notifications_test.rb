require "application_system_test_case"

class PaymentNotificationsTest < ApplicationSystemTestCase
  setup do
    @payment_notification = payment_notifications(:one)
  end

  test "visiting the index" do
    visit payment_notifications_url
    assert_selector "h1", text: "Payment notifications"
  end

  test "should create payment notification" do
    visit payment_notifications_url
    click_on "New payment notification"

    fill_in "Cart", with: @payment_notification.cart_id
    fill_in "Params", with: @payment_notification.params
    fill_in "Status", with: @payment_notification.status
    fill_in "Transaction", with: @payment_notification.transaction_id
    click_on "Create Payment notification"

    assert_text "Payment notification was successfully created"
    click_on "Back"
  end

  test "should update Payment notification" do
    visit payment_notification_url(@payment_notification)
    click_on "Edit this payment notification", match: :first

    fill_in "Cart", with: @payment_notification.cart_id
    fill_in "Params", with: @payment_notification.params
    fill_in "Status", with: @payment_notification.status
    fill_in "Transaction", with: @payment_notification.transaction_id
    click_on "Update Payment notification"

    assert_text "Payment notification was successfully updated"
    click_on "Back"
  end

  test "should destroy Payment notification" do
    visit payment_notification_url(@payment_notification)
    click_on "Destroy this payment notification", match: :first

    assert_text "Payment notification was successfully destroyed"
  end
end
