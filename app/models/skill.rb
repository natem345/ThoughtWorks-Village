class Skill < ActiveRecord::Base

  COMFORT = {"(1) Novice" => "Novice",
    "(2) Competent" => "Competent",
    "(3) Proficient" => "Proficient",
    "(4) Expert" => "Expert"}

  belongs_to :user
end
