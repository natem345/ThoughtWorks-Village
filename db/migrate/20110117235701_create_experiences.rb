class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.string :type
      t.integer :length_in_years
      t.integer :comfort_level
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
