class Api::V1::ApiKeysController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [ :create, :destroy, :user_edit]

    # def index
    #     render json: current_bearer.api_keys 

    # end
    # def create
    #   user = User.find_by(email: params[:email])
    #   if user && user.valid_password?( params[:password])
    #       api_key = user.api_keys.create! token: SecureRandom.hex 
   
    #       render json: api_key, status: :created and return 
    #     end 
   
    #   render json: :unauthorized
    # end

      def create
        user = User.find_by_email( params[:email])
        if user && user.valid_password?( params[:password])
          token = user.generate_jwt
          render json: token.to_json
        else
          render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
        end
      end

      
      
      def user_edit

        render json: 'dffdf'
      end  



   
    # def destroy
    #     current_api_key&.destroy
    # end
end
