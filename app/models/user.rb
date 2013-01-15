class User < ActiveRecord::Base
  serialize :settings, ActiveRecord::Coders::Hstore

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :messages

 before_create :generate_defaults
  def generate_defaults
    self.api_key = SecureRandom.hex    
    self.settings = {} #Why do I need to initialize this here?
  end
  
end
