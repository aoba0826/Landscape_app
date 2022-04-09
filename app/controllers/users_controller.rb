class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user


  def show
  end

  def edit
    redirect_to post_images_path unless current_user.id == @user.id
  end

  def update
    @user.update(user_params)

    render :show
  end

  def task_list
    @task_planning = Task.where(user_id: @user.id,status: 0).page(params[:page]).per(4).order(id: :DESC)
    @task_in_progress = Task.where(user_id: @user.id,status: 1).page(params[:page]).per(4).order(id: :DESC)
    @task_crosed = Task.where(user_id: @user.id,status: 2).page(params[:page]).per(4).order(id: :DESC)
    
    redirect_to post_images_path unless current_user.id == @user.id
  end

  def follow_list
    @users_follower = @user.follower_user
    @users_followed = @user.following_user
    redirect_to post_images_path unless current_user.id == @user.id
  end

  private
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :profile_image)
  end
end
