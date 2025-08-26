class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params.merge(user: current_user))
    if comment.save
      redirect_to post, notice: "Commented."
    else
      redirect_to post, alert: "Comment failed."
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    if comment.user == current_user || post.user == current_user
      comment.destroy
      redirect_to post, notice: "Comment removed."
    else
      redirect_to post, alert: "Not allowed."
    end
  end

  private
  def comment_params
     params.require(:comment).permit(:body)
  end
end
