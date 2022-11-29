class Car < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    validates :name, presence: true
    ratyrate_rateable "speed", "engine", "price"
end
