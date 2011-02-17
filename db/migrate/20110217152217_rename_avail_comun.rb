class RenameAvailComun < ActiveRecord::Migration
  def self.up
	rename_column :availability_calendars, :user_id, :mentor_id
	
  end

  def self.down
  end
end
