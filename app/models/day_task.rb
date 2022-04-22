class DayTask < ApplicationRecord
  belongs_to :user
  belongs_to :schedule_day
  
  validates :task_contents,:start_time,:end_time, presence: true

  def set_the_day_implement
    year = self.schedule_day.schedule_day.year
    month = self.schedule_day.schedule_day.month
    day = self.schedule_day.schedule_day.day

    self.start_time = self.start_time.change(year: year, month: month, day: day)
    self.end_time = self.end_time.change(year: year, month: month, day: day)
  end

end

