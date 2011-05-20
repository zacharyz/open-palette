class Heart < ActiveRecord::Base
  attr_accessible :hearted_id, :hearter_id
  belongs_to :hearter, :class_name => "User"
  belongs_to :hearted, :class_name => "Post" 
  
  validates :hearter_id, :presence => true
  validates :hearted_id, :presence => true
end
