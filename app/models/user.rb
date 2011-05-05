class User < ActiveRecord::Base
  validates_presence_of :name

  validates_uniqueness_of :email,
  :case_sensitive => false,
  :allow_nil => false,
  :allow_blank => false
  validates_format_of :email,
  :message => "must be a valid email address.",
  :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\z/

  validates_length_of :password,
  :minimum => 8,
  :allow_nil => false,
  :allow_blank => false

  validates_uniqueness_of :phone, :allow_blank => true
  validates_format_of :phone,
  :message => "must be a valid telephone number.",
  :with => /^[\(\)0-9\- \+\.]{10,20} *[extension\.]{0,9} *[0-9]{0,5}$/i

  validates_confirmation_of :email
  validates_presence_of :email_confirmation

  validates_confirmation_of :password
  validates_presence_of :password_confirmation
  
  has_many :skills

  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(user_info)
    User.where(:email => user_info[:email],
               :password => user_info[:password]).first
  end
end
