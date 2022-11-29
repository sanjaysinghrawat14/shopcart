class CheckoutController < ApplicationController
  before_action :set_cart
include ApplicationHelper
  def index
    if total_cart_items.blank?
      flash[:alert] = "there is no item in cart"
      redirect_to root_path
    end
    @address = Address.new
    @addresses =Address.all
  end

  def create
   
    @address = Address.new(set_params)
    @address.user = current_user
    respond_to do |format|
      if @address.save
        format.html { redirect_to checkout_path, notice: "address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy

    respond_to do |format|
      format.html { redirect_to address_new_path, notice: "address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

def place_order_new
# debugger
@cart = Cart.find(session[:cart_id]) if session[:cart_id]

if total_cart_items.blank?
  flash[:alert] = "there is no item in cart"
    redirect_to root_path
  end
  @address = Address.find(params[:address_id])

end



def place_order
# debugger

if total_cart_items.blank?
  flash[:alert] = "there is no item in cart"
  redirect_to root_path
end


if !(params[:stripeToken].blank?)
token = params[:stripeToken]
card_brand = params[:user][:card_brand]
card_exp_month = params[:user][:card_exp_month]
card_exp_year = params[:user][:card_exp_year]
card_last4 = params[:user][:card_last4]

# charge = Stripe::Charge.create(
#       amount: 1,
#       currency: "usd",
#       description: "Test",
#       source: token
#     )


    current_user.stripe_id = 1
    current_user.card_brand = card_brand
    current_user.card_exp_month = card_exp_month
    current_user.card_exp_year = card_exp_year
    current_user.card_last4 = card_last4
    current_user.save!
end
  @cart.destroy if @cart.id == session[:cart_id]
  session[:cart_id] = nil

  respond_to do |format|
    format.html { redirect_to root_path, notice: "Order place successfully." }
    format.json { head :no_content }
  end

end


private

def set_params
  params.require(:address).permit(:address)

end

end
