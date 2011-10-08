class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :catch_cancel, :update => [:create, :update, :destroy]

  private

    def catch_cancel
      redirect_back_or root_path if params[:commit] == "Cancel"
    end
end
