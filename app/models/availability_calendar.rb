class AvailabilityCalendar < ActiveRecord::Base
  belongs_to :user
  has_many :availability_days
end
