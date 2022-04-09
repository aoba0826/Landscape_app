class Task < ApplicationRecord
  belongs_to :user
  belongs_to :post_image
  has_many_attached :task_images
  
  enum status: { planning: 0, in_progress: 1, closed: 2 }
end
