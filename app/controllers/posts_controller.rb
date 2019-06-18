class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @posts = Post.find(params[:id])
  end

  def edit
    require_user
    @post = Post.find(params[:id])
    if @post.user != nil
      @user = @post.user
      validate_user(@user.id)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: 'Successfully Edited Post'
    else
      render :edit
    end
  end

  def new
    require_user
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: 'Successfully created post'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :body)
  end
end
