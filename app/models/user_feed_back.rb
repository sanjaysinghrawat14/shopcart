class UserFeedBack < ApplicationRecord
  belongs_to :user
  belongs_to :product
  default_scope { order(created_at: :desc)}

  validates :rating, presence: true, length: { minimum: 1,  maximum: 5}

end
