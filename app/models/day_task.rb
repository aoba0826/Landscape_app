class DayTask < ApplicationRecord
  belongs_to :user
  belongs_to :schedule_day

  validates :task_contents, :start_time, :end_time, presence: true

  def set_the_day_implement
    year = schedule_day.schedule_day.year
    month = schedule_day.schedule_day.month
    day = schedule_day.schedule_day.day

    self.start_time = start_time.change(year: year, month: month, day: day)
    self.end_time = end_time.change(year: year, month: month, day: day)
  end
end
