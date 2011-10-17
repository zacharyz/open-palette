class PagesController < ApplicationController   
  before_filter :new_post, :except => :destroy
  def home
                             
    @tags = Post.tag_counts_on(:tags).limit(15).sort_by(&:count).reverse
    if signed_in?
      @title = "Hey #{current_user.name}, here are some posts"
      #@feed_items = current_user.feed.paginate(:page => params[:page],:per_page => 18)       
      @posts = current_user.feed.page(params[:page]).per(18)                             
      @new_post = Post.new
    else
      @posts = Post.page(params[:page]).per(18) 
    end
  end  
  def location
    @title = 'where are you?'
  end
  def contact
    @title = 'Contact'
  end
        
  def about
    @title = 'About'
  end

  def help
    @title = "Help"
  end
  private
    def new_post
      @new_post = Post.new
    end
end
