class TasksController < ApplicationController
  before_action :set_task, except: [:create,:task_calender]
  def create
    @task = current_user.tasks.new(task_params)
      unless @task.task_image.present?
        post_image = PostImage.find(params[:task_image])
        @task.task_image.attach(post_image.image.blob)
      end
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

  def task_calender
    @tasks = Task.where(user_id: current_user.id)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:user_id,:title_task,:task_place,:content,:status,:start_time,:end_time,:task_image)
  end
end
