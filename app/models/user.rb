class User < ApplicationRecord
  before_create :add_unsubscribe_hash
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        #  :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
        #  :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
       
       #for rail-jwt
        # :jwt_authenticatable, jwt_revocation_strategy: self
        

     

   has_many :addresses
   has_many :projects
has_many :project_users
has_many :projects, through: :project_users
has_many :user_feed_backs, dependent: :destroy
ratyrate_rater

def jwt_payload
  super.merge('foo' => 'bar')
end

def generate_jwt
  JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secrets.secret_key_base)
end






private
def add_unsubscribe_hash
self.unsubscribe_hash = SecureRandom.hex
end

end
