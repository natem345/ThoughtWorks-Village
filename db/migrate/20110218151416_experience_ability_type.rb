class ExperienceAbilityType < ActiveRecord::Migration
  def self.up
    change_table :experiences do |t|
      t.change :ability, :string
    end
  end

  def self.down
  end
end
