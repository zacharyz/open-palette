source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
gem 'sqlite3-ruby','1.3.2', :require => 'sqlite3'
gem 'gravatar_image_tag', '1.0.0.pre2'
#gem 'will_paginate', '3.0.pre2' 
gem 'kaminari'
gem 'faker', '0.3.1'
# gem 'aws-s3', :require => 'aws/s3'

#gem 'simplegeo'

gem 'fog'
gem 'rmagick'  
gem 'carrierwave'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :development do
  gem 'rspec-rails'
  #gem 'annotate-models', '1.0.4'
  #gem 'ZenTest'
  #gem 'autotest'
  #gem 'autotest-rails-pure'
  #gem 'autotest-growl'            
  #gem 'autotest-fsevent'
  
end

group :test do
  gem 'rspec'
  gem 'webrat', '0.7.1'
  gem 'spork', '0.9.0.rc5'
  #gem 'ZenTest'
  gem 'factory_girl_rails', '1.0'  
end

group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

gem 'json'

gem 'jquery-rails'

gem 'haml'

gem 'bootstrap-sass', '1.3.0'
   
gem 'acts-as-taggable-on', '~>2.1.0'

# Rails 3.1 - Heroku
group :production do
  gem 'therubyracer-heroku', '~> 0.8.1.pre3'
  gem 'pg'
end