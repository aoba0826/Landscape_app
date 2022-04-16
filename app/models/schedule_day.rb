class ScheduleDay < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many :day_tasks, dependent: :destroy
end
