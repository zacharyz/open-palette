class PostsController < ApplicationController 
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  # GET /posts
  # GET /posts.xml
  def index
    #@posts = Post.all.paginate(:page => params[:page],:per_page => 18) 
    @posts = Post.order("name").page(params[:page]).per(18)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
      format.js
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "post created!"
      respond_to do |format|
        format.html { redirect_back_or root_path }
        format.js { render :action => :redirect }
      end
    else
      flash[:error] = "Something isn't right."
      respond_to do |format|
        format.html { render 'new' }
        format.js
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_back_or root_path
  end
  
  def hearts
    @title = "Hearts"
    @post = Post.find(params[:id])
    #@users = @post.hearters.paginate(:page => params[:page])
    @users = @post.hearters.page(params[:page])
    render 'show_heart'
  end
  private

    def authorized_user
      @post = Post.find(params[:id])
      redirect_to root_path unless current_user?(@post.user)
    end
end
