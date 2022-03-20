class Task < ApplicationRecord
  belongs_to :user
  belongs_to :post_image
  has_many_attached :task_images
end
