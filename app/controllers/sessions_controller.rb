class SessionsController < ApplicationController
  layout :choose_layout
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"               
      respond_to do |format|
        format.html { render 'new' }
        format.js
      end
    else
      sign_in user
      flash[:success] = "Welcome back!"
      logger.debug "debugging create"
      respond_to do |format|
        format.html { redirect_back_or root_path }
        format.js { render :action => :redirect }
      end
    end
  end
  
  def destroy
    sign_out
    flash[:success] = "Come back soon!"
    redirect_to root_path
  end
  private  
    def choose_layout  
      (request.xhr?) ? nil : 'application'  
    end
end
