class PostImagesController < ApplicationController
  before_action :set_post_image, except: [:new, :create, :index, :search]
  before_action :set_task, except: [:new, :create, :edit]

  def new
    @user = current_user
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(image_params)
    @post_image.user_id = current_user.id
    unless @post_image.star.presence
      @post_image.star = 0
    end
    if @post_image.save
      flash.now[:notice] = '投稿しました'
      redirect_to post_images_path
    else
      flash.now[:alert] = '投稿できませんでした'
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
    redirect_to post_images_path unless current_user.id == @post_image.user_id
  end

  def update
    @post_image.update(image_params)
    @post_comment = PostComment.new
    render :show
  end

  def search
    if params[:keyword].present?
      @post_images = PostImage.searching(params[:keyword]).page(params[:page]).per(12)
    else
      @post_images = PostImage.page(params[:page]).per(12)
      flash.now[:alert] = '未入力です。'
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
