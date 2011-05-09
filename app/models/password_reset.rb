class PasswordReset < ActiveRecord::Base
  validates_presence_of :user_id
  validates_uniqueness_of :user_id

  validates_presence_of :code
  validates_uniqueness_of :code

  belongs_to :user
end
