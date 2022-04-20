class Task < ApplicationRecord
  belongs_to :user
  has_many :schedule_days, dependent: :destroy

  has_one_attached :task_image

  def get_task_image
    unless task_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      task_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    task_image
  end

  enum status: { planning: 0, in_progress: 1, closed: 2 }
end
