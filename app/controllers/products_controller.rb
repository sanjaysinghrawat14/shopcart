    class ProductsController < ApplicationController
      before_action :set_cart
      def index
        
       unless params[:category_id].blank?
        @category = Category.find(params[:category_id])
        @products =  @category.products
        else
        @products = Product.all
        end
      end

      def subcategories
        @category = Category.find(params[:category_id])
        @sub_categories = @category.subcategories
        if  @sub_categories
          render partial: "shared/data"
        end
      end



      def new
        @product = Product.new
      end
     
      def edit
        @product = Product.find(params[:id])
      end
      def show
        @cart_item = CartItem.new
        @product = Product.find(params[:id])
        @user_feed_back_data =  UserFeedBack.where(product_id: @product.id)
        @user_feed_backs =   UserFeedBack.find_by(product_id: @product.id, user_id: current_user.id)
        if  @user_feed_backs.blank?
        #   @user_feed_backs = UserFeedBack.find_by(product_id: @product.id, user_id: current_user.id)
        # else
          @user_feed_backs = UserFeedBack.new
        end
      end

      # POST /instruments or /instruments.json
  def create
    @product =  Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_path(@product), notice: "product was successfully created." }
        format.json { render :show, status: :created, location: @instrument }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params())

      flash[:notice] = "product was updated successfully."
      redirect_to admin_product_path(@product)
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:brand, :model, :description, :condition, :finish, :price, :title, category_ids: [])
    # params.require(:product).permit(:title, :description, :dat_created, :picture, category_ids: [])
  end
      
    end
  