class AddPostsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :posts_count, :integer, :default => 0
    User.all.each do |u|
         User.update_counters u.id, :posts_count => u.posts.count
    end
  end  
end
