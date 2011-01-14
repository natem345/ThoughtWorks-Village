class CreateAvailabilityCalendars < ActiveRecord::Migration
  def self.up
    create_table :availability_calendars do |t|
      t.integer :availabilityQuotient

      t.timestamps
    end
  end

  def self.down
    drop_table :availability_calendars
  end
end
