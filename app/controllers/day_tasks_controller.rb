class DayTasksController < ApplicationController

  def create
    @day_task = current_user.day_tasks.new(day_task_params)
    @day_task.set_the_day_implement
    @day_tasks = current_user.day_tasks.where(schedule_day_id: @day_task.schedule_day.id).order(start_time: :ASC)
    unless  @day_task.save
      render :error
    end
  end

  def destroy
    @day_task = DayTask.find(params[:id])
    @day_task.destroy
    @day_tasks = current_user.day_tasks.where(schedule_day_id: @day_task.schedule_day.id).order(start_time: :ASC)
  end
  private

  def day_task_params
    params.require(:day_task).permit(:schedule_day_id,:task_contents,:start_time,:end_time)
  end
end
