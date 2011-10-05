class PagesController < ApplicationController   
  def home
    @title = "Home"
    if signed_in?
      #@feed_items = current_user.feed.paginate(:page => params[:page],:per_page => 18)       
      @feed_items = current_user.feed.page(params[:page]).per(18) 
    else
      @feed_items = Post.page(params[:page]).per(18) 
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
end
