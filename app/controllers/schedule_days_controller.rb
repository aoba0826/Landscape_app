class ScheduleDaysController < ApplicationController
  def create
    @schedule_day = ScheduleDay.new(schedule_day_params)
    @schedule_day.user_id = current_user.id
    @schedule_day.save
    render :index
  end

  def index
  end

  def destroy
  end

  private
  
  def schedule_day_params
    params.require(:schedule_day).permit(:task_id,:schedule_day)
  end
end
