class DayTasksController < ApplicationController

  def create
    @day_task = current_user.day_tasks.new(day_task_params)
    @day_task.set_the_day_implement
    @day_task.save
    redirect_to schedule_day_path(@day_task.schedule_day_id)
  end

  private

  def day_task_params
    params.require(:day_task).permit(:schedule_day_id,:task_contents,:start_time,:end_time)
  end
end
