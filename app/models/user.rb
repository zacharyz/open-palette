# == Schema Information
# Schema version: 20110502214350
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  acts_as_tagger
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
	validates :name,  :presence => true,
                      :length   => { :maximum => 50 }
  validates :password, :presence     => true,
                         :confirmation => true,
                         :length       => { :within => 6..40 }
  before_save :encrypt_password
                         
	has_many :posts, :dependent => :destroy 
	
	scope :popular, :order => 'posts_count desc', :limit => 9
	
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower   
  
  has_many :hearts, :foreign_key => "hearter_id",
                           :dependent => :destroy
  has_many :hearted, :through => :hearts, :source => :hearted
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                  
  def feed
    Post.from_users_followed_by(self)
  end
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  def heart?(hearted)
    hearts.find_by_hearted_id(hearted)
  end

  def heart!(hearted)
    hearts.create!(:hearted_id => hearted.id)
  end 
  
  def unheart!(hearted)
    hearts.find_by_hearted_id(hearted).destroy
  end                                 
  
  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end                  
end
