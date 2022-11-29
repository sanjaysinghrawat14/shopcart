class Api::V1::ProductsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]
  #  skip_before_action :verify_authenticity_token, only: [ :index]
  # before_action :authenticate_user!, only: [:index]
 
  respond_to :json
  before_action :process_token

  # before_action :authenticate_user!
  # def index
  #   render json: current_user, status: :ok
  # end


  def index
     @products = Product.all
    #  render json: @products
     render json: @products, status: :ok
  end
  
 
end
