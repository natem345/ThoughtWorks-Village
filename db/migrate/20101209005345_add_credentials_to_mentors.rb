class AddCredentialsToMentors < ActiveRecord::Migration
  def self.up
    add_column :mentors, :email, :string
    add_column :mentors, :password, :string
  end

  def self.down
    remove_column :mentors, :password
    remove_column :mentors, :email
  end
end
