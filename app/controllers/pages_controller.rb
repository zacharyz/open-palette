class PagesController < ApplicationController   
  def home
    @title = "Home"
    if signed_in?
      #@feed_items = current_user.feed.paginate(:page => params[:page],:per_page => 18)       
      @feed_items = current_user.feed.page(params[:page]).per(18) 
    end
  end
  def artwalk
    logger.debug "params #{params}" 
    @places = 
    @title = "Portland Art Walk"
    #SimpleGeo::Client.set_credentials('Prhfx4xKNBYnxLnaersACEKEtusVZNmp', 'hMu2vMCcGC4Z67QEwq8DpgMm5fEDLcvq')
    @places = SimpleGeo::Client.get_places(37.772445,-122.405913)
    if params[:lat]
      @places = SimpleGeo::Client.get_places(params[:lat],params[:long])
    end
    respond_to do |format|
      format.js
      format.xml
      format.html
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
