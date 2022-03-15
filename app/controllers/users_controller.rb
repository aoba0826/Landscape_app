class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def task_list
  @user = User.find(params[:id])
  @tasks = Task.where(user_id: @user.id)
  
  end
end
