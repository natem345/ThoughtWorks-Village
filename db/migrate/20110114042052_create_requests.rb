class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.string :reason
      t.string :estimatedLength
      t.integer :mentee_id
      t.integer :mentor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
