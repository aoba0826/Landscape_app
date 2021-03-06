class PostImage < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  has_one_attached :image
  belongs_to :user
  has_many   :likes, dependent: :destroy
  has_many   :post_comments, dependent: :destroy
  has_many   :notifications, dependent: :destroy
  has_many :post_image_tags, dependent: :destroy
  has_many :tags, through: :post_image_tags

  validates :title, length: { maximum: 50 }
  validates :title, :place, :introduction, :image, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.searching(keyword)
    where(['title LIKE ? or place LIKE ? or introduction LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visiter_id = ? and visited_id = ? and post_image_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_image_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.visiter_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    # 取得したユーザーIDの分だけ通知を作成するとき、同じ通知が複数回登録されてしまうことを防ぐため = distinctメソッド
    temp_ids = PostComment.select(:user_id).where(post_image_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_image_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visiter_id == notification.visited_id
    notification.save if notification.valid?
  end

  def save_tags(tags)
    post_image_tags.destroy_all
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      post_image_tags.find_or_create_by(tag_id: tag.id)
    end
  end
end
