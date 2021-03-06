class LikesController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    like = current_user.likes.new(post_image_id: @post_image.id)
    like.save

    # 通知の作成
    @post_image.create_notification_like!(current_user)
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    like = current_user.likes.find_by(post_image_id: @post_image.id)
    like.destroy
  end
end
