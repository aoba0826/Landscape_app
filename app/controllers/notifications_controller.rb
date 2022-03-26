class NotificationsController < ApplicationController
  def index
    # current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications
    # @notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    # デフォルトがfalseなのでeachメソットを回してtrueに変更する。
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end

    @notifications = @notifications.page(params[:page]).order(created_at: :desc).per(15)
     redirect_to post_images_path unless current_user.id == @notification.user_id
  end

  def destroy_all
    # 通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
