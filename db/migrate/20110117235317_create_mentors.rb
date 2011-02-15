class CreateMentors < ActiveRecord::Migration
  def self.up
    create_table :mentors do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :mentors
  end
end
