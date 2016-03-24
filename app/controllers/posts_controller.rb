class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy,:upvote,:downvote]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show 
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.user = current_user
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @post.user == current_user
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }        
      end
    else
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was not destroyed. You do not own this post' } 
      end
    end
  end
  
  def upvote
    if current_user.voted_up_on? @post
      @post.unvote_by current_user
    else  
      @post.upvote_by current_user
    end
    redirect_to posts_path
  end 

  def downvote
    if current_user.voted_down_on? @post
      @post.unvote_by current_user
    else  
      @post.downvote_by current_user
    end
    redirect_to posts_path
  end 

  
private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :contents, :author_id)
  end
end
