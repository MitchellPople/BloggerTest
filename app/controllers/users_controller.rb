class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def index
    @user = User.all
  end

  def show
  end

  def edit
    if logged_in?
      validate_user(@user.id)
    else
      require_user
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Successfully Edited Profile'
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Successfully created user'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
