require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    #make_posts
    make_relationships
    #make_hearts
  end
end

def make_users
  admin = User.create!(:name => "Zachary",
               :email => "zacharyz@gmail.com",
               :password => "foobar",
               :password_confirmation => "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example#{n+1}@zfighter.com"
    password  = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_posts
  User.all.each do |user|
    num = 0
    9.times do
      title = Faker::Lorem.sentence(1)
      content = Faker::Lorem.sentence(5)
      num = num + 1
      image = "http://placehold.it/290x290"
      user.posts.create!(:content => content,:image => image,:title=> title)
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end                                                  

def make_hearts
  users = User.all
  posts = Post.all
  user  = users.first
  post = posts.first
  hearters = users[1..50]
  hearted = posts[3..50]     
  
  hearted.each { |hearted_post| user.heart!(hearted_post) }
  hearters.each { |hearter| hearter.heart!(post)}
end