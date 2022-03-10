class LikesController < ApplicationController
  
  
  def create
    post_image = PostImage.find(params[:post_image_id])
    like = Like.new(post_image_id: post_image.id)
    like.user_id = current_user.id
    like.save
     
      #通知の作成
      post_image.create_notification_like!(current_user)
      
    redirect_to request.referer
  end
  
  
  def destroy
    post_image = PostImage.find(params[:post_image_id])
    like = Like.find_by(post_image_id: post_image.id)
    like.user_id = current_user.id
    like.destroy
    redirect_to request.referer
  end
  
end
