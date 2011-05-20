class CreateHearts < ActiveRecord::Migration
  def self.up
    create_table :hearts do |t|
      t.integer :hearter_id
      t.integer :hearted_id

      t.timestamps
    end
    add_index :hearts, :hearter_id
    add_index :hearts, :hearted_id
    add_index :hearts, [:hearter_id, :hearted_id], :unique => true
  end

  def self.down
    drop_table :hearts
  end
end
