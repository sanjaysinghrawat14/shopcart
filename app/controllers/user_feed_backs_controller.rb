class UserFeedBacksController < ApplicationController
  def new
    @user_feed_backs = UserFeedBack.new
  end

  def create
    # debugger
    @user_feed_backs = UserFeedBack.new(user_feed_backs_params)
    @user_feed_backs.user_id = current_user.id

    @product = Product.find(@user_feed_backs.product_id)
    respond_to do |format|
      if @user_feed_backs.save
        format.html { redirect_to product_path( @product), notice: "review was successfully created." }
        format.json { render :show, status: :created, location: @user_feed_backs }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_feed_backs.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # debugger
    @user_feed_backs = UserFeedBack.find(params[:id])
    @product = Product.find(@user_feed_backs.product_id)

    # if @user_feed_backs.update(user_feed_backs_params)
    #    redirect_to product_path( @product)
    # else
    #    render :new
    # end


    respond_to do |format|
      if @user_feed_backs.update(user_feed_backs_params)
        format.html { redirect_to product_path(@product), notice: "review was successfully updated." }
        format.json { render :show, status: :ok, location: @user_feed_backs }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_feed_backs.errors, status: :unprocessable_entity }
      end
    end

  end





  private
 
 
  def user_feed_backs_params

    params.require(:user_feed_back).permit(:rating, :comment, :product_id)
  end

end
