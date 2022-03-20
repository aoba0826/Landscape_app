class PostImagesController < ApplicationController
  def new
    @user = current_user
    @post_image = PostImage.new
  end

  def index
    @post_images = PostImage.page(params[:page]).per(12)
    @task = Task.new
  end

  def create
    @post_image = PostImage.new(image_params)
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

    @task = Task.new
    @post_images = PostImage.page(params[:page]).per(12)
    render :index
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    @post_image.update(image_params)

    @post_comment = PostComment.new
    @task = Task.new
    render :show
  end

  def search
    @task = Task.new
    if params[:keyword].present?
      @post_images = PostImage.where(['title LIKE ? or place LIKE ? or introduction LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
    else
      @post_images = PostImage.page(params[:page]).per(12)
      @task = Task.new
      render :index
    end
  end

  private

  def image_params
    params.require(:post_image).permit(:title, :place, :introduction, :user_id, :image, :star)
  end
end
