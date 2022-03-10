class PostImagesController < ApplicationController
  def index
    @user = current_user
    @post_image = PostImage.new
    @post_images = PostImage.all
    @task = Task.new
    
  end
  
  def create
    @post_image = PostImage.new(imaage_params)
    @post_image.user_id = current_user.id
    @post_image.save
  
    redirect_to post_images_path
  end


  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @task = Task.new
  end
  
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    
    @post_images = PostImage.all
    @user = current_user
    render :index
  end

  def edit
     @post_image = PostImage.find(params[:id])
  end
  
  def update
  end
  
  private
  
  def imaage_params
    params.require(:post_image).permit(:title,:place,:introduction,:user_id,:image)
  end
  
end
