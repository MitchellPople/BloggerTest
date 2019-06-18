class CommentsController < ApplicationController
  def edit
    require_user
    @comment = Comment.find(params[:id])
    if @comment.user != nil
      @user = @comment.user
      validate_user(@user.id)
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Successfully Edited Comment'
    else
      render :edit
    end
  end

  def new
    require_user
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(comment_params[:post_id])
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'Successfully created comment'
    else
      render :new
    end
  end

  def show
    @post = Comment.find(params[:id]).post
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
