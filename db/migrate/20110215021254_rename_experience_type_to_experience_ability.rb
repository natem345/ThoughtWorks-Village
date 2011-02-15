class RenameExperienceTypeToExperienceAbility < ActiveRecord::Migration
  def self.up
	rename_column :experiences, :type, :ability
  end

  def self.down
	rename_column :experiences, :ability, :type
  end
end
