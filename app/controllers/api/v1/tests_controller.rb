class Api::V1::TestsController < ApplicationController
    # skip_before_action :authenticate_user!, only: [:index]
     skip_before_action :verify_authenticity_token, only: [ :user_edit]
    # before_action :authenticate_user!, only: [:index]
    respond_to :json
    before_action :process_token
  

    
    def user_edit
      @user = User.find(2);

      @user.update(name: params[:name], email: params[:email])
      render json:  @user
    end  


  end
  