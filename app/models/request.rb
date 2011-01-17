class Request < ActiveRecord::Base
  belongs_to :mentee
  belongs_to :mentor
end
