class RegistrationsController < Devise::RegistrationsController
   
  #   respond_to :json
  #   private

  # def respond_with(resource, _opts = {})
  #   register_success && return if resource.persisted?

  #   register_failed
  # end

  # def register_success
  #   render json: { message: 'Signed up sucessfully.' }
  # end

  # def register_failed
  #   render json: { message: "Something went wrong." }
  # end




  #use for simple jwt gem
  # def create
  #   user = User.new(sign_up_params)
  
  #   if user.save
  #   token = user.generate_jwt
  #     render json: token.to_json
  #   else
  #     render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  #   end
  # end


 # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    # sign_up_params
    # account_update_params

    # debugger
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated

      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end







   

    
    private

     def sign_up_params
        params.require(:user).permit(:name, :username, :email, :password, :password_confirm)
     end

     def account_update_params
        params.require(:user).permit(:name, :username, :email, :password, :password_confirm, :current_password)
     end








  #for devise-jwt

  # respond_to :json
  # private

  # def respond_with(resource, _opts = {})
  #   if resource.persisted?
  #     render json: {
  #       status: {code: 200, message: 'Signed up sucessfully.'},
  #       data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
  #     }
  #   else
  #     render json: {
  #       status: {message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
  #     }, status: :unprocessable_entity
  #   end
  # end







  end