class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post.likes.find_or_create_by!(user: current_user)
    redirect_to post
  end

  def destroy
    post = Post.find(params[:post_id])
    post.likes.where(user: current_user).destroy_all
    redirect_to post
  end
end
