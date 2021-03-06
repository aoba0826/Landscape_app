class PostCommentsController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = current_user.post_comments.new(comment_params)
    @post_comment.post_image_id = @post_image.id
    @post = @post_comment.post_image
    if @post_comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      # 通知の作成
      @post.create_notification_comment!(current_user, @post_comment.id)
    else
      render :error
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id]).destroy
    flash.now[:alert] = '投稿を削除しました'

    @post_image = PostImage.find(params[:post_image_id])
  end

  private

  def comment_params
    params.require(:post_comment).permit(:comment)
  end
end
