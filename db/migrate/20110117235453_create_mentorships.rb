class CreateMentorships < ActiveRecord::Migration
  def self.up
    create_table :mentorships do |t|
      t.references :mentor
      t.references :mentee

      t.timestamps
    end
  end

  def self.down
    drop_table :mentorships
  end
end
