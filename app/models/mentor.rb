class Mentor < User
  include Gravtastic
  gravtastic
  has_one :availability_calendar
  has_many :requests
  has_many :mentorships
  has_many :mentees, :through => :mentorships
end
