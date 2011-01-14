class CreateMentees < ActiveRecord::Migration
  def self.up
    create_table :mentees do |t|
      t.integer :menteeID

      t.timestamps
    end
  end

  def self.down
    drop_table :mentees
  end
end
