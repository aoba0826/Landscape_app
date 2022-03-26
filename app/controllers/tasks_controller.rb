class TasksController < ApplicationController
  before_action :set_task, except: [:create]
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.save
    redirect_to task_list_user_path(@task.user.id)
  end

  def show
     redirect_to post_images_path unless current_user.id == @task.user_id
  end

  def edit
     redirect_to post_images_path unless current_user.id == @task.user_id
  end

  def update
    @task.update(task_params)
    redirect_to task_list_user_path(@task.user.id)
  end

  def destroy
    @task.destroy
    redirect_to request.referer
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:user_id, :post_image_id, :title_task, :task_place, :content)
  end
end
