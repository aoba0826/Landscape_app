class TasksController < ApplicationController
 
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.save
    redirect_to task_path(@task.id)
  end
  def show
    @task = Task.find(params[:id])

  end


  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to task_path(@task.id)
  end

  private

  def task_params
    params.require(:task).permit(:user_id,:post_image_id,:title_task,:task_place,:content)
  end
end
