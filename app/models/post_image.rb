class Post_image < ApplicationRecord
  
  has_many_attached :images
  belongs_to :user
  has_many   :likes          , dependent: :destroy
  has_many   :post_comments  , dependent: :destroy
  has_many   :notifications  , dependent: :destroy
  has_many   :tasks          , dependent: :destroy
  
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
end
