class CreateMentees < ActiveRecord::Migration
  def self.up
    create_table :mentees do |t|
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mentees
  end
end
