class Category < ApplicationRecord
    has_many :product_categories
    has_many :products, through: :product_categories

    has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
    belongs_to :parent_category, :class_name => "Category",  :foreign_key => "parent_id", :optional => true
  
    validates :name, presence: true, length: { minimum: 2,  maximum: 100}
    # validates :parent_id , presence: true

end
