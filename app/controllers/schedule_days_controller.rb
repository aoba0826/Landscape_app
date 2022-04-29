class ScheduleDaysController < ApplicationController
  def create
    @schedule_day = current_user.schedule_days.find_or_create_by(schedule_day_params)
    @day_task = DayTask.new
    @day_tasks = current_user.day_tasks.where(schedule_day_id: @schedule_day.id).order(start_time: :ASC)
    render :show
  end

  def show
    @schedule_day = ScheduleDay.find(params[:id])
    @day_task = DayTask.new
    @day_tasks = current_user.day_tasks.where(schedule_day_id: @schedule_day.id).order(start_time: :ASC)
  end

  private

  def schedule_day_params
    params.require(:schedule_day).permit(:task_id, :schedule_day)
  end
end
