class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]
  def index
    @pagy, @users = pagy User.all, items: Settings.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success"
      redirect_to user_path @user
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to users_path
    else
      flash.now[:danger] = t ".error"
      render :edit
    end
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
      redirect_to users_path
    else
      flash[:danger] = t ".error"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit :first_name, :last_name, :birthday, :gender, :phone, :email
  end

  def find_user
    @user = User.find params[:id]
  end
end
