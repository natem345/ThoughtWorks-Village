class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses
  
  accepts_nested_attributes_for :responses
end
