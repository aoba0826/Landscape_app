class NotificationsController < ApplicationController
  def index
     # @notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    @notifications = current_user.passive_notifications

    # デフォルトがfalseなのでeachメソットを回してtrueに変更する。
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @notifications = @notifications.page(params[:page]).order(created_at: :desc).per(15)
  end

  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
