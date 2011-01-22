class RemoveUserPolymorphism < ActiveRecord::Migration
  def self.up
	remove_column :users, :accountable_id
	remove_column :users, :accountable_type
  end

  def self.down
	add_column :users, :accountable_id, :integer
	add_column :users, :accountable_type, :string
  end
end
