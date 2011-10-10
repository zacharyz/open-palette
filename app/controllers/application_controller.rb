class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :catch_cancel, :update => [:create, :update, :destroy]
  
  private                            
    def catch_cancel
      if params[:commit] == "Cancel" 
        respond_to do |format|
          format.html { redirect_back_or root_path }
          format.js { render :action => :cancel }
        end
      end
    end
end
