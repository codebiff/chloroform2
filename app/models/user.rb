class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :messages

  before_create :generate_defaults
  def generate_defaults
    self.api_key = SecureRandom.hex    
  end
  
end
