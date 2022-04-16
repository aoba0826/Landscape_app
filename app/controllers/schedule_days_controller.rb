class ScheduleDaysController < ApplicationController
  def create
    @schedule_day = current_user.schedule_days.find_or_create_by(schedule_day_params)
    @day_task = DayTask.new
    @day_tasks = current_user.day_tasks.all
    render :index
  end

  def index
    @day_task = DayTask.new
    @day_tasks = current_user.day_tasks.all
  end
  
  def show
  
  end

  def destroy
  end

  private

  def schedule_day_params
    params.require(:schedule_day).permit(:task_id,:schedule_day)
  end
end
