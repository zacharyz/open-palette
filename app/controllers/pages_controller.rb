class PagesController < ApplicationController
  def home 
    @title = 'home'
  end

  def contact
    @title = 'contact'
  end

end
