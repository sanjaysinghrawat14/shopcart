class Address < ApplicationRecord
  belongs_to :user

  has_rich_text :address

end
