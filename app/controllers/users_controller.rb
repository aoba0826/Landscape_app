class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)

    render :show
  end

  def task_list
    @tasks = Task.where(user_id: @user.id).page(params[:page]).per(4).order(id: :DESC)
  end

  def follow_list
    @users_follower = @user.follower_user
    @users_followed = @user.following_user
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :profile_image)
  end
end
