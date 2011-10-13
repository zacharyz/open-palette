class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create                  
    logger.debug "debuging relat create #{params}"
    @user = User.find(params[:id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
