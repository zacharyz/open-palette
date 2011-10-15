class HeartsController < ApplicationController
  before_filter :authenticate

  def create
    @post = Post.find(params[:id])
    current_user.heart!(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:id])
    current_user.unheart!(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end
end
