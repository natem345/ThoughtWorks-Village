class Mentee < User
  has_many :mentorships
  has_many :mentors, :through => :mentorships
  has_many :requests
  
end
