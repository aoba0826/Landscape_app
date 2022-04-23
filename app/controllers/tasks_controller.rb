class TasksController < ApplicationController
  before_action :set_task, except: [:create,:task_calender,:index]
  def create
    @task = current_user.tasks.new(task_params)
      unless @task.task_image.present? || !params[:task_image]
        post_image = PostImage.find(params[:task_image])
        @task.task_image.attach(post_image.image.blob)
      end
      if @task.save
          redirect_to tasks_path
      else
        set_task_index
        render :index
      end
  end

  def index
    @task = Task.new
    set_task_index
  end

  def edit
  end

  def update
    if @task.update(task_params)
       set_task_index
      render :index
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    set_task_index
    redirect_to request.referer
  end

  def task_calender
    @tasks = current_user.tasks.all
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def set_task_index
    @task_planning = current_user.tasks.where(status: 0).page(params[:page]).per(4).order(id: :DESC)
    @task_in_progress = current_user.tasks.where(status: 1).page(params[:page]).per(4).order(id: :DESC)
    @task_crosed = current_user.tasks.where(status: 2).page(params[:page]).per(4).order(id: :DESC)
  end

  def task_params
    params.require(:task).permit(:user_id,:title_task,:task_place,:content,:status,:start_time,:end_time,:task_image)
  end
end
