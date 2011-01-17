class CreateMentors < ActiveRecord::Migration
  def self.up
    create_table :mentors do |t|
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mentors
  end
end
