class Tag < ApplicationRecord
  has_many :post_image_tags, dependent: :destroy
  has_many :post_images, through: :post_image_tags,foreign_key: 'tag_id'
end
