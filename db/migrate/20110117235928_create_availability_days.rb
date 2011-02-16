class CreateAvailabilityDays < ActiveRecord::Migration
  def self.up
    create_table :availability_days do |t|
      t.date :availability_day
      t.string :availability
      t.references :availability_calendar

      t.timestamps
    end
  end

  def self.down
    drop_table :availability_days
  end
end
