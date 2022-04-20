class PostImagesController < ApplicationController
  before_action :set_post_image, except: [:new, :create, :index, :search,:search_tag]
  before_action :set_task, except: [:new, :create, :edit]

  def new
    @user = current_user
    @post_image = PostImage.new
  end

  def create
    @post_image = current_user.post_images.new(image_params)
    unless @post_image.star.presence
      @post_image.star = 0
    end
    if @post_image.save
      flash.now[:notice] = '投稿しました'
      tags = Vision.get_image_data(@post_image.image)
      @post_image.save_tags(tags)

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
    tags = Vision.get_image_data(@post_image.image)
    @post_image.save_tags(tags)
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

  def search_tag
    @tag_list=Tag.all
    unless  params[:tag_id].blank?
      @tag = Tag.find(params[:tag_id])
      @post_images = @tag.post_images.page(params[:page]).per(12)
    else
      render :search_tag
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
