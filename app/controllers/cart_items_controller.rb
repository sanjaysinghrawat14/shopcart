class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show edit update destroy ]
  before_action :set_cart, only: [:create, :quantity_update]

  # GET /cart_items or /cart_items.json
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1 or /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new

  end

  # GET /cart_items/1/edit
  def edit
  end

  #do for showing error but now handle using there controller
  # def product_show
  #   @product = Product.find(params[:id])
  # end

  # POST /cart_items or /cart_items.json
  def create
     # we are getting @cart from the applicationcontroller
     quantity = 1
     @product = Product.find(params[:product_id])
     quantity = params[:product][:quantity] if params[:product][:quantity].present?
     @cart_item = @cart.add_product_to_cart( @product, quantity)
    #  debugger
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to cart_path(@cart_item.cart), notice: "Cart item was successfully created." }
        format.json { render :show, status: :created, location: @cart_item.cart }
      else
        format.html {render template: 'products/show', :id => @product.id, status: :unprocessable_entity}
        # format.html {render 'products/show', :id => @product.id, status: :unprocessable_entity}
        # format.html {render "products/show/#{@product.id}", status: :unprocessable_entity }
        # format.html { render :product_show, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end



def quantity_update
  @product = Product.find(params[:product_id])
  @cart_item = @cart.cart_items.find_by(product_id: @product.id)

  @cart_item.quantity = params[:quantity]
  if @cart_item.quantity > 0
    if @cart_item.save
        sub_price = ActionController::Base.helpers.number_to_currency(@cart_item.product.price * @cart_item.quantity) 
        total_price = ActionController::Base.helpers.number_to_currency(@cart.total_price)
        data = {"quantity"=> @cart_item.quantity, "sub_price"=> sub_price, "total_price"=> total_price}
        render json: data
    else
        flash.now[:alert] = "#{@cart_item.errors.full_messages}"
        # test = render partial: "shared/message"
        render(partial: "shared/message")
        # render json: { partial: "shared/message", }
    end
  else
    flash.now[:alert] = "Qunatity cannot be zero"
    render partial: "shared/message"
  end

end






  # PATCH/PUT /cart_items/1 or /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to cart_item_url(@cart_item), notice: "Cart item was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1 or /cart_items/1.json

 # DELETE /line_items/1 or /line_items/1.json
 def destroy
  @cart = Cart.find(session[:cart_id])

  @cart_item.destroy

  respond_to do |format|
    format.html { redirect_to cart_path(@cart), notice: "Cart item was successfully destroyed." }
    format.json { head :no_content }
  end
end


  # def destroy
  #   @cart_item.destroy

  #   respond_to do |format|
  #     format.html { redirect_to cart_items_url, notice: "Cart item was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:product_id, :cart_id, :quantity)
    end
end
