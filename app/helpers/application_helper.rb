module ApplicationHelper

    def menus
        Category.includes(:subcategories)
     end

    #  def total_cart_items
    #     if session[:cart_id]
    #     @cart = Cart.find(session[:cart_id]) 
    #     @cart.cart_items
    #     end
    #  end
    #  def cart_count_over_one
    #     if session[:cart_id]
    #         @cart = Cart.find(session[:cart_id]) 
    #         @cart.cart_items.count
    #         end
        
    #  end
     
        def show_errors(object, field_name)
            # debugger
            if object.errors.any?
                # debugger
                if !object.errors.messages[field_name].blank?
                    object.errors.messages[field_name].join(", ")
                end
            end
        end 

     def average_rating(user_feed_back_data)
         sum= 0 
         average_rating = 0
         user_feed_back_data.each do |x|  
             sum = sum + x.rating 
         end
        average_rating = (sum/user_feed_back_data.count).ceil  

     end


     def cart_count_over_one
        return total_cart_items if total_cart_items > 0
      end
    
      def total_cart_items
         if !(session[:cart_id].blank?)
            @cart =Cart.find(session[:cart_id])
            total = @cart.cart_items.map(&:quantity).sum
            return total if total > 0
        end
      end

      def render_stars(rating)
        StarsRenderer.new(rating, self).render_stars
      end

end
