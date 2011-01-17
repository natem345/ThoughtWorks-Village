class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :location
      t.string :current_position
      t.string :school
      t.string :major
      t.integer :total_years_experience
      t.string :email
      t.string :password
      t.integer :phone
      t.text :interests
      t.references :accountable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
