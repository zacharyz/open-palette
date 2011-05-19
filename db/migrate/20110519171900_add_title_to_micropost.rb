class AddTitleToMicropost < ActiveRecord::Migration
  def self.up
    add_column :microposts, :title, :string
  end

  def self.down
    remove_column :microposts, :title
  end
end
