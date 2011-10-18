class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @title = "All users"
    #@users = User.paginate(:page => params[:page])
    @users = User.page(params[:page])  
  end

  def show
  
    @user = User.find(params[:id])
    #@posts = @user.posts.paginate(:page => params[:page])  
    @posts = @user.posts.page(params[:page])  
    @title = @user.name
  end
  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Settings updated."
      respond_to do |format|
          format.html { redirect_to @user }
          format.js { render :action => :redirect }
      end                                    
    else
      @title = "Edit user"
      respond_to do |format|
        format.html { render 'edit' }
        format.js
      end
    end
  end
  def new
    @user = User.new
    @title = "Sign up"
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Open Palette!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  def following
    @title = "Following"
    @user = User.find(params[:id])
    #@users = @user.following.paginate(:page => params[:page])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    #@users = @user.followers.paginate(:page => params[:page]) 
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end
  
  def hearts
    @title = "#{current_user.name}'s favorites"
    @user = User.find(params[:id])
    #@posts = @user.hearted.paginate(:page => params[:page])
    @posts = @user.hearted.page(params[:page])
    render :show
  end                  
  
  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
