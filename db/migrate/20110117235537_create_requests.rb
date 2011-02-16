class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.string :reason
      t.string :estimated_length
      t.references :mentor
      t.references :mentee

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
