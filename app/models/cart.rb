class Cart < ApplicationRecord
    has_many :cart_items, dependent: :destroy

    has_many :order2s
    # has_one :order2


    def add_product_to_cart(product, item_quantity)
      cart_item = self.cart_items.find_by(product_id: product.id)
      if cart_item
        if !(item_quantity.blank?)
            cart_item.quantity = cart_item.quantity + item_quantity.to_i
         end
        # cart_item = cart_item.increment(:quantity)
      else
        cart_item = self.cart_items.build(product_id: product.id)
      end
      cart_item
    end

    def total_price
        total_price = 0;
         self.cart_items.each do |cart_item|
            total_price = total_price + cart_item.product.price * cart_item.quantity
        end
        total_price
    end
  
   
    def check_product_quantity(product)
        if  cart_item.quantity > product.quantity
             return false
        end
        return true
    end

    def paypal_url(return_url, notify_url)
        values = {
          :business => 'sb-bu83a14721126@business.example.com',
          :cmd => '_cart',
          :upload => 1,
          :return => return_url,
          :invoice => id,
          :notify_url => notify_url
        }
        cart_items.each_with_index do |item, index|
          values.merge!({
            "amount_#{index+1}" => item.product.price,
            "item_name_#{index+1}" => item.product.model,
            "item_number_#{index+1}" => item.id,
            "quantity_#{index+1}" => item.quantity
          })
        end
        values
      end




end
