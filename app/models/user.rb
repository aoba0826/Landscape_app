class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :nickname, presence: true

  has_one_attached :profile_image
  has_many :post_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :schedule_days, dependent: :destroy
  
  has_many :active_notifications,  class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.nickname = "ゲストユーザー"
    end
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end
  # フォローしている
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされてる
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしている人
  has_many :follower_user, through: :followed, source: :follower
  # フォローされている人
  has_many :following_user, through: :follower, source: :followed

  # 1. followメソッド　＝　フォローする
  def follow(user_id)
    follower.create!(followed_id: user_id)
  end

  # 2. unfollowメソッド　＝　フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # 3. followingメソッド　＝　既にフォローしているかの確認
  def following?(user)
    following_user.include?(user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    return if temp.present?

    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end
end
