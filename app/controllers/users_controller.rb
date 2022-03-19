class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    
    render :show
  end


  def task_list
    @user = User.find(params[:id])
    @tasks = Task.where(user_id: @user.id).page(params[:page]).per(4)
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:nickname,:email,:profile_image)
  end
end
