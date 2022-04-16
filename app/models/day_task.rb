class DayTask < ApplicationRecord
  belongs_to :user
  belongs_to :schedule_day
end

