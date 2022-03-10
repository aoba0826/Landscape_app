class PostCommentsController < ApplicationController

  def create
   post_image = PostImage.find(params[:post_image_id])
   post_comment = PostComment.new(comment_params)
   post_comment.post_image_id = post_image.id
   post_comment.user_id = current_user.id
   
   if post_comment.save
      #通知の作成
      post_comment.create_notification_comment!(current_user, post_comment.id)
    redirect_to post_image_path(post_image.id)
   end
  end

  def destroy
   post_comment = PostComment.find(params[:id])
   post_comment.destroy

   redirect_to request.referer
  end

  private

  def comment_params
   params.require(:post_comment).permit(:comment)
  end
end
