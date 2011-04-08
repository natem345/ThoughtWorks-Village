class ChangeExperiencesToSkills < ActiveRecord::Migration
  def self.up
	rename_table(:experiences, :skills)
	remove_column(:users,:interests)
	change_column(:skills,:comfort_level,:string)
	rename_column(:skills,:ability,:title)
  end

  def self.down
  end
end
