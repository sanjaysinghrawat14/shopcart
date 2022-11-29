class SessionsController  < Devise::SessionsController 
  # respond_to :json
  # def create
  #   user = User.find_by_email(sign_in_params[:email])
  
  #   if user && user.valid_password?(sign_in_params[:password])
  #     token = user.generate_jwt
  #     render json: token.to_json
  #   else
  #     render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  #   end
  # end


  #for devise-jwt
  # respond_to :json
  # private

  # def respond_with(resource, _opts = {})
  #   render json: {
  #     status: {code: 200, message: 'Logged in sucessfully.'},
  #     data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
  #   }, status: :ok
  # end

  # def respond_to_on_destroy
  #   if current_user
  #     render json: {
  #       status: 200,
  #       message: "logged out successfully"
  #     }, status: :ok
  #   else
  #     render json: {
  #       status: 401,
  #       message: "Couldn't find an active session."
  #     }, status: :unauthorized
  #   end
  # end












      protected

    def after_sign_in_path_for(resource)
      if resource.admin?
        admin_root_path
      else
         root_path
      end

    end

   
    # private

    # # def respond_with(resource, _opts = {})
    # #   render json: { message: 'You are logged in.' }, status: :ok
    # # end
  
    # def respond_to_on_destroy
    #   log_out_success && return if current_user
  
    #   log_out_failure
    # end
  
    # def log_out_success
    #   render json: { message: "You are logged out." }, status: :ok
    # end
  
    # def log_out_failure
    #   render json: { message: "Hmm nothing happened."}, status: :unauthorized
    # end

end