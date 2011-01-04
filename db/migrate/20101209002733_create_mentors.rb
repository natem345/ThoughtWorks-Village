class CreateMentors < ActiveRecord::Migration
  def self.up
    create_table :mentors do |t|
      t.string :name
      t.string :location
      t.string :current_position
      t.string :school
      t.string :major
      t.int :total_years_experience

      t.timestamps
    end
  end

  def self.down
    drop_table :mentors
  end
end
