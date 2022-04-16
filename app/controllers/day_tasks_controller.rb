class DayTasksController < ApplicationController

  def create
    @day_task = current_user.day_tasks.new(day_task_params)
    @day_task.save
    redirect_to schedule_days_path
  end

  private
  def day_task_params
    params.require(:day_task).permit(:schedule_day_id,:start_time,:end_time)
  end
end
