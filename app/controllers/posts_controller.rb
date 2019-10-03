class PostsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @posts = Post.includes(:user).order("id DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(title: post_params[:title], image: post_params[:image], text: post_params[:text], user_id: current_user.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy if current_user.id == post.user_id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params) if current_user.id == post.user_id
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  private
  def post_params
    params.permit(:title, :image, :text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
