class ApplicationController < ActionController::Base
    # skip_before_action :verify_authenticity_token
    before_action :configure_permitted_parameters, if: :devise_controller?
    # helper_method :set_cart
    # include CurrentCart
    # before_action :set_cart 

    # before_action :authenticate_user!
    
  
    
  
    # If user has not signed in, return unauthorized response (called only when auth is needed)
    # def authenticate_user!(options = {})
    #   head :unauthorized unless signed_in?
    # end
  
    # # set Devise's current_user using decoded JWT instead of session
    # def current_user
    #   @current_user ||= super || User.find(@current_user_id)
    # end
  
    # # check that authenticate_user has successfully returned @current_user_id (user is authenticated)
    # def signed_in?
    #   @current_user_id.present?
    # end



    def check_admin!
        authenticate_user! && current_user.admin?
      end

   

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update , keys: [:name])
      devise_parameter_sanitizer.permit(:sign_up ,keys: [:name])
    end

     private



    # Check for auth headers - if present, decode or send unauthorized response (called always to allow current_user)
    def process_token
      # debugger
      if request.headers['Authorization'].present?
        begin
          jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.secrets.secret_key_base).first
          @current_user_id = jwt_payload['id']
        
          @test = User.find(@current_user_id)
          # debugger
          # current_user_id = session[:user_id]
          # @current_user_data ||= User.find(current_user_id) if current_user_id

          if params[:id] !=  @current_user_id
            render json: 'user not match'
          end

        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      else
        render json: 'Please add token in the request'
        # raise ActiveRecord::RecordInvalid, 'token is required' 
          # "Email can't be blank, Password can't be blank"
          # head :unauthorized
      end
    end




    def set_cart
      @cart =Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart =Cart.create
      session[:cart_id] = @cart.id
    end

end
