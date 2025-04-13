class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user, only: [ :edit, :update, :destroy ]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.author = current_user.email

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return redirect_to posts_url, alert: "You are not authorized to perform this action." unless current_user == @post.user

    if @post.destroy
      redirect_to posts_url, notice: "Post was successfully destroyed."
    else
      redirect_to posts_url, alert: "Failed to destroy post."
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:slug])
  end

  def authorize_user
    unless current_user == @post.user
      redirect_to posts_url, alert: "You are not authorized to perform this action."
    end
  end

  def post_params
    params.require(:post).permit(:title, :description, :body, :author, :hero_image_url)
  end
end
