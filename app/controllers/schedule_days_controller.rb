class ScheduleDaysController < ApplicationController
  def create
    @schedule_day = current_user.schedule_days.find_or_create_by(schedule_day_params)
    render :index
  end

  def index
    @schedule_day
  end

  def destroy
  end

  private

  def schedule_day_params
    params.require(:schedule_day).permit(:task_id,:schedule_day)
  end
end
