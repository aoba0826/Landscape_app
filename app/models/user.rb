class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
           
    has_one_attached :image      
    has_many :post_images    , dependent: :destroy
    has_many :likes          , dependent: :destroy
    has_many :post_comments  , dependent: :destroy
    has_many :tasks          , dependent: :destroy
    
    has_many :active_notifications,  class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
    has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  
    # フォローしている
    has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    # フォローされてる
    has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    #フォローしている人
    has_many :follower_user, through: :followed, source: :follower
    #フォローされている人
    has_many :following_user, through: :follower, source: :followed
      # 1. followメソッド　＝　フォローする
      
      
    def follow(user_id)
     follower.create(followed_id: user_id)
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
      temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
      if temp.blank?
        notification = current_user.active_notifications.new(
          visited_id: id,
          action: 'follow'
        )
        notification.save if notification.valid?
      end
    end
    
end
