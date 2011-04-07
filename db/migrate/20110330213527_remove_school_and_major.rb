class RemoveSchoolAndMajor < ActiveRecord::Migration
  def self.up
    remove_column :users, :school
    remove_column :users, :major
  end

  def self.down
    add_column :users, :school, :string
    add_column :users, :major, :string
  end
end
