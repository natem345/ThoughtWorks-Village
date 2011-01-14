class User < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => true
  validates_length_of :password, :minimum => 8
  validates_presence_of :password
  validates_numericality_of :phone, :only_integer => true, :greater_than => 0
  validates_uniqueness_of :phone, :allow_blank => true
end
