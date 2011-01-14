class CreateAvailabilityDays < ActiveRecord::Migration
  def self.up
    create_table :availability_days do |t|
      t.date :availabilityDay
      t.string :availability

      t.timestamps
    end
  end

  def self.down
    drop_table :availability_days
  end
end
