class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:edit,:update, :switch, :destroy, :index]
  before_action :set_post, only: [:update, :switch, :destroy]

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render "index"
    end
  end

  def index
    if params[:id].present?
      @post = Post.find(params[:id])
    else
      @post = Post.new
    end
    @posts = Post.where(user_id: current_user.id, switch: 0)
    @done = Post.where(user_id: current_user.id, switch: 1)
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render "index"
    end
  end

  def switch
    @post.user_id = current_user.id
    if @post.switch == 0
      @post.update(switch: 1)
      redirect_to posts_path
    else
      @post.update(switch: 0)
      redirect_to posts_path
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:item, :switch, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
