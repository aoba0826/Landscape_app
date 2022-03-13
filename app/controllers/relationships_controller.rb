class RelationshipsController < ApplicationController
  def follow
    user_follow = User.find(params[:user_id])
    @users_follower = user_follow.follower_user
    user_followed = User.find(params[:user_id])
    @users_followed = user_followed.following_user
  end

  def show
  end
  
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    
    @user.create_notification_follow!(current_user)
    
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
end
