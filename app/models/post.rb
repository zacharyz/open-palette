class Post < ActiveRecord::Base
  attr_accessible :content,:image, :title, :remote_image_url   
                                     
  has_many :hearts, :foreign_key => "hearted_id",
                           :dependent => :destroy
  has_many :hearters, :through => :hearts, :source => :hearter
    
  belongs_to :user
  
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  default_scope :order => 'posts.created_at DESC'

  # Return posts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  mount_uploader :image, ImageUploader
  private

    # Return an SQL condition for users followed by the given user.
    # We include the user's own id as well.
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
    end
end
