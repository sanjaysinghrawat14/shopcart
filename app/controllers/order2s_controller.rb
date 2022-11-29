class Order2sController < ApplicationController
  before_action :set_order2, only: %i[ show edit update destroy ]
  before_action :set_cart

  # GET /order2s or /order2s.json
  def index
    @order2s = Order2.all
  end

  # GET /order2s/1 or /order2s/1.json
  def show
  end

  # GET /order2s/new
  def new
    @order2 = Order2.new(express_token: params[:token])
  end


  def express
    response = EXPRESS_GATEWAY.setup_purchase(10,
      :ip                => request.remote_ip,
      :return_url        => new_order2_url,
      :cancel_return_url => products_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token),  allow_other_host: true
  end

  # GET /order2s/1/edit
  def edit
  end
  def failure
  end
  def success
  end
  # POST /order2s or /order2s.json
  def create
    # @order2 = Order2.new(order2_params)
    # debugger
    @order2 = @cart.order2s.build(order2_params)
    @order2.ip_address = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish 

    respond_to do |format|
      if @order2.save
          if @order2.purchase
            @cart.destroy if @cart.id == session[:cart_id]
            session[:cart_id] = nil
            @responseData = @order2.transactions.first.params
            format.html {  render :success , status: :unprocessable_entity }
          else
            @responseData = @order2.transactions.first.params
            format.html {  render :failure , status: :unprocessable_entity }
          end
        # format.html { redirect_to order2_url(@order2), notice: "Order2 was successfully created." }
        # format.json { render :show, status: :created, location: @order2 }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order2.errors, status: :unprocessable_entity }
      end
    end
  end


  # def create
  #   @order2 = @cart.order2s.build(order2_params)
  #   @order2.ip_address = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish 
  #     respond_to do |format|
  #       if @order2.save
  #         if @order2.purchase
  #           render :action => "success"
  #         else
  #           render :action => "failure"
  #         end
  #       else
  #         render :action => 'new'
  #       end
  #   end
  # end



  # PATCH/PUT /order2s/1 or /order2s/1.json
  def update
    respond_to do |format|
      if @order2.update(order2_params)
        format.html { redirect_to order2_url(@order2), notice: "Order2 was successfully updated." }
        format.json { render :show, status: :ok, location: @order2 }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order2.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order2s/1 or /order2s/1.json
  def destroy
    @order2.destroy

    respond_to do |format|
      format.html { redirect_to order2s_url, notice: "Order2 was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order2
      @order2 = Order2.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order2_params
      params.require(:order2).permit( :first_name, :last_name, :card_type, :card_number, :card_verification, :card_expires_on, :express_token, :express_payer_id)
    end
end
