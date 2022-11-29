class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :cart_items, dependent: :destroy
  has_rich_text :description
  mount_uploader :image, ImageUploader
  has_many :user_feed_backs, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2,  maximum: 100}
  # validates :description, presence: true, length: { minimum: 3, maximum: 400}
  validates :price, presence: true
  validates :image, presence: true
 


  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

end
