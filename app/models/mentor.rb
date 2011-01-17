class Mentor < ActiveRecord::Base
  has_one :availability_calendar
  has_many :mentorships
  has_many :mentees, :through => :mentorships
  has_many :requests
  has_one :user, :as => :accountable
end
