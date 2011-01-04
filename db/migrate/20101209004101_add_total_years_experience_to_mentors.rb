class AddTotalYearsExperienceToMentors < ActiveRecord::Migration
  def self.up
    add_column :mentors, :total_years_experience, :int
  end

  def self.down
    remove_column :mentors, :total_years_experience
  end
end
