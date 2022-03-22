class PostCommentsController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = PostComment.new(comment_params)
    @post_comment.post_image_id = @post_image.id
    @post_comment.user_id = current_user.id
    @post = @post_comment.post_image
    if @post_comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      # 通知の作成
      @post.create_notification_comment!(current_user, @post_comment.id)
      redirect_to post_image_path(@post_image.id)
    else
      render 'post_images/show'
    end
      
  end

  def destroy
    post_comment = PostComment.find(params[:id]).destroy
    flash.now[:alert] = '投稿を削除しました'

    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:post_comment).permit(:comment)
  end
end
