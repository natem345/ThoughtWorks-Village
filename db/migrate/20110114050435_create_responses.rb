class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.string :responseText
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
