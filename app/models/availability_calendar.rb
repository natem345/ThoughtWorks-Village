class AvailabilityCalendar < ActiveRecord::Base
  belongs_to :user
  has_many :availability_days
  accepts_nested_attributes_for :availability_days, :allow_destroy => true
end
