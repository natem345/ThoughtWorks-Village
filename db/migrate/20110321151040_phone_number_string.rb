class PhoneNumberString < ActiveRecord::Migration
  def self.up
	change_column :users, :phone, :string
  end

  def self.down
  end
end
