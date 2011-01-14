class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.string :type
      t.integer :lengthInYears
      t.integer :comfortLevel

      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
