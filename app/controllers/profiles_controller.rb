class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to user_profile_path(current_user), notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def profile_params; params.require(:profile).permit(:display_name, :bio); end
end
