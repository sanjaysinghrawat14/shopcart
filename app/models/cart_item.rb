class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  
  validate :check_product_quantity
   
   private
   def check_product_quantity
     product_quantity = Product.find(self.product_id).quantity
    #  debugger
     if self.quantity > product_quantity
      errors.add(:quantity, "There is not enough quantity regarding this product")
    end
  # debugger
    if self.quantity <= 0
      errors.add(:quantity, "There sholud be one qunatity")
    end
   end

end
