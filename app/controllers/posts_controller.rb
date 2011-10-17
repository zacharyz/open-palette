class PostsController < ApplicationController 
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  before_filter :new_post, :except => :destroy
  # GET /posts
  # GET /posts.xml
  def index
    @tags = Post.tag_counts_on(:tags).limit(15).sort_by(&:count).reverse
    if signed_in?
      @title = "Hey #{current_user.name}, here are some posts"
      @posts = current_user.feed.page(params[:page]).per(18)                             
      @new_post = Post.new
    else
      @posts = Post.page(params[:page]).per(18) 
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @hearters = @post.hearters.limit(9)
    respond_to do |format|
      format.html # show.html.erb
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
    
    if @post.update_attributes(params[:post])
      respond_to do |format|
        flash[:success] = 'post was successfully updated.'
        logger.debug "debug: updated post"
        format.html {redirect_back_or root_path}
        format.js {render :action => :update }
      end
      
    else
      respond_to do |format|
        flash[:error] = "Something isn't right"
        format.html { render :action => "edit" }
        format.js { render :action => :edit}
      end    
    end  


  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js { render :action => :redirect }
    end
  end
  
  def hearts
    @title = "Hearts"
    @post = Post.find(params[:id])
    #@users = @post.hearters.paginate(:page => params[:page])
    @users = @post.hearters.page(params[:page])
    render 'show_heart'
  end
  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end                  
  
  def tag              
    @title = "Posts tagged with '#{params[:id]}'"
    @tags = Post.tag_counts_on(:tags).limit(15).sort_by(&:count).reverse
    @posts = Post.tagged_with(params[:id]).page(params[:page]).per(18)                      
    respond_to do |format|
        format.html { render :index }
        format.js {render :action => :update_posts }
    end  
  end
  private
    def new_post
      @new_post = Post.new
    end
    def authorized_user
      @post = Post.find(params[:id])
      redirect_to root_path unless current_user?(@post.user)
    end
end
