class Task < ApplicationRecord
  belongs_to :user
  has_many :schedule_days, dependent: :destroy

  has_one_attached :task_image

  enum status: { planning: 0, in_progress: 1, closed: 2 }
end
