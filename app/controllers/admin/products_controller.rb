module Admin
    class ProductsController < Admin::ApplicationController
      # Overwrite any of the RESTful controller actions to implement custom behavior
      # For example, you may want to send an email after a foo is updated.
      #
      # def update
      #   super
      #   send_foo_updated_email(requested_resource)
      # end
      def index
        @products = Product.all
      end


      def new
        @product = Product.new
      end
     
      def edit
        @product = Product.find(params[:id])
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
    params.require(:product).permit(:brand, :model, :description, :condition, :finish, :price, :title,:image, :quantity, category_ids: [])
    # params.require(:product).permit(:title, :description, :dat_created, :picture, category_ids: [])
  end
      # Override this method to specify custom lookup behavior.
      # This will be used to set the resource for the `show`, `edit`, and `update`
      # actions.
      #
      # def find_resource(param)
      #   Foo.find_by!(slug: param)
      # end
  
      # The result of this lookup will be available as `requested_resource`
  
      # Override this if you have certain roles that require a subset
      # this will be used to set the records shown on the `index` action.
      #
      # def scoped_resource
      #   if current_user.super_admin?
      #     resource_class
      #   else
      #     resource_class.with_less_stuff
      #   end
      # end
  
      # Override `resource_params` if you want to transform the submitted
      # data before it's persisted. For example, the following would turn all
      # empty values into nil values. It uses other APIs such as `resource_class`
      # and `dashboard`:
      #
      # def resource_params
      #   params.require(resource_class.model_name.param_key).
      #     permit(dashboard.permitted_attributes).
      #     transform_values { |value| value == "" ? nil : value }
      # end
  
      # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
      # for more information
    end
  end
  