class PostImagesController < ApplicationController
  before_action :set_post_image, except: [:new,:create,:index,:search]
  before_action :set_task,except: [:new,:create,:edit]

  def new
    @user = current_user
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(image_params)
    @post_image.user_id = current_user.id
     if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.page(params[:page]).per(12)
  end

  def show
    @post_comment = PostComment.new
  end

  def destroy
    @post_image.destroy
    @post_images = PostImage.page(params[:page]).per(12)
    render :index
  end

  def edit
  end

  def update
    @post_image.update(image_params)
    @post_comment = PostComment.new
    render :show
  end

  def search
    if params[:keyword].present?
      @post_images = PostImage.where(['title LIKE ? or place LIKE ? or introduction LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).page(params[:page]).per(12)
    else
      @post_images = PostImage.page(params[:page]).per(12)
      render :index
    end
  end

  private

  def set_post_image
    @post_image = PostImage.find(params[:id])
  end

  def set_task
    @task = Task.new
  end

  def image_params
    params.require(:post_image).permit(:title, :place, :introduction, :user_id, :image, :star)
  end
end
