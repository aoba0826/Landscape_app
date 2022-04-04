class Tag < ApplicationRecord
  has_many :post_images, through: :post_image_tags
  has_many :post_image_tags, dependent: :destroy

  def self.save_tags(tag)
    post_image_tag = Tag.find_or_create_by(name: tag)
    return post_image_tag
  end
 
end
