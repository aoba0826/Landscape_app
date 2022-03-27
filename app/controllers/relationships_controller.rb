class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])

    @user.create_notification_follow!(current_user)
    @users = current_user
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    @users = current_user
  end
end
