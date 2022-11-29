class PaymentNotificationsController < ApplicationController
  before_action :set_payment_notification, only: %i[ show edit update destroy ]
  protect_from_forgery :except => [:create]

  # GET /payment_notifications or /payment_notifications.json
  def index
    @payment_notifications = PaymentNotification.all
  end

  # GET /payment_notifications/1 or /payment_notifications/1.json
  def show
  end

  # GET /payment_notifications/new
  def new
    @payment_notification = PaymentNotification.new
  end

  # GET /payment_notifications/1/edit
  def edit
  end

  def create
    PaymentNotification.create!(:params => params, :cart_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])
    render :nothing => true
  end



  # # POST /payment_notifications or /payment_notifications.json
  # def create
  #   @payment_notification = PaymentNotification.new(payment_notification_params)

  #   respond_to do |format|
  #     if @payment_notification.save
  #       format.html { redirect_to payment_notification_url(@payment_notification), notice: "Payment notification was successfully created." }
  #       format.json { render :show, status: :created, location: @payment_notification }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @payment_notification.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /payment_notifications/1 or /payment_notifications/1.json
  def update
    respond_to do |format|
      if @payment_notification.update(payment_notification_params)
        format.html { redirect_to payment_notification_url(@payment_notification), notice: "Payment notification was successfully updated." }
        format.json { render :show, status: :ok, location: @payment_notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_notifications/1 or /payment_notifications/1.json
  def destroy
    @payment_notification.destroy

    respond_to do |format|
      format.html { redirect_to payment_notifications_url, notice: "Payment notification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_notification
      @payment_notification = PaymentNotification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_notification_params
      params.require(:payment_notification).permit(:params, :cart_id, :status, :transaction_id)
    end
end
