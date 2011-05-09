class CreatePasswordResets < ActiveRecord::Migration
  def self.up
    create_table :password_resets do |t|
      t.references :user
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :password_resets
  end
end
