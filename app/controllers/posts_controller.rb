class PostsController < ApplicationController
    def index
        @posts = Post.all
    end
    def show
        @posts = Post.find(params[:id])
    end
    def new
        @post = Post.new
    end
    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to @post, notice: "Successfully created post"
        else
            render :new
        end
    end

    private
    def post_params
        params.require(:post).permit(:title, :summary, :body)
    end
end
