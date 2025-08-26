class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = current_user.feed
    @post  = Post.new
  end

  def show; end
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Posted!"
    else
      @posts = current_user.feed
      flash.now[:alert] = "Could not post."
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    authorize!(@post)
    if @post.update(post_params)
      redirect_to @post, notice: "Updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize!(@post)
    @post.destroy
    redirect_to posts_path, notice: "Deleted."
  end

  private
  def set_post; @post = Post.find(params[:id]); end
  def post_params; params.require(:post).permit(:body); end
  def authorize!(post); redirect_to root_path, alert: "Not yours" unless post.user == current_user; end
end
