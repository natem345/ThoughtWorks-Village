class User < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates_length_of :password, :minimum => 8
  validates_presence_of :password
  validates_numericality_of :phone, :only_integer => true, :greater_than => 0
  validates_uniqueness_of :phone, :allow_blank => true
  
  has_many :experiences

  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(user_info)
    User.where(:email => user_info[:email], :password => user_info[:password]).first
  end
end

