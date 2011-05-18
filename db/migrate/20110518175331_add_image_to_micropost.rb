class AddImageToMicropost < ActiveRecord::Migration
  def self.up                        
    add_column :microposts, :image, :string
  end

  def self.down
    remove_column :microposts, :image
  end
end
