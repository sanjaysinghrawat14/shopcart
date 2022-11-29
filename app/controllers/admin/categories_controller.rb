module Admin
    class CategoriesController < Admin::ApplicationController
      # Overwrite any of the RESTful controller actions to implement custom behavior
      # For example, you may want to send an email after a foo is updated.
      #
      # def update
      #   super
      #   send_foo_updated_email(requested_resource)
      # end
     
     
      def index
        # debugger
        search_term = params[:search].to_s.strip
       
        if !(search_term.blank?)
        @categories = Category.where("name LIKE :name1", {:name1 => "#{search_term}%"})
        else
          @categories = Category.all
        end
        render locals: {
          search_term: search_term,
        }
      end


      def new
        @category = Category.new
        @categories = Category.where(parent_id: nil)

    end

    def edit
      @category = Category.find(params[:id])
      @categories = Category.where(parent_id: nil)

    end

    def create
      @category =  Category.new(cateory_params)
      @categories = Category.where(parent_id: nil)

      respond_to do |format|
        if @category.save
          format.html { redirect_to admin_category_path(@category), notice: "category was successfully created." }
          format.json { render :show, status: :created, location: @category }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end
   
    private

    def cateory_params
      params.require(:category).permit(:name, :short_description, :long_description, :dat_upto, :parent_id)
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
  