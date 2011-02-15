class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.string :description
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
