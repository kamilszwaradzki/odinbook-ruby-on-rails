class FollowsController < ApplicationController
  def index
    @incoming = current_user.passive_follows.pending.includes(:follower)
    @outgoing = current_user.active_follows.pending.includes(:followed)
  end

  def create
    followed = User.find(params[:user_id])
    follow = current_user.active_follows.find_or_initialize_by(followed:)
    follow.status ||= :pending
    if follow.save
      redirect_to users_path, notice: "Request sent."
    else
      redirect_to users_path, alert: "Could not send."
    end
  end

  def update
    follow = Follow.find(params[:id])
    if follow.followed == current_user
      follow.update!(status: params[:status]) # "accepted" or "declined"
      redirect_to follows_path, notice: "Updated."
    else
      redirect_to follows_path, alert: "Not allowed."
    end
  end

  def destroy
    follow = Follow.find(params[:id])
    if follow.follower == current_user || follow.followed == current_user
      follow.destroy
      redirect_to follows_path, notice: "Request canceled."
    else
      redirect_to follows_path, alert: "Not allowed."
    end
  end
end
