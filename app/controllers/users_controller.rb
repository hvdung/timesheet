class UsersController < AuthorizeController
  before_action :find_user, only: [:show, :destroy]
  def index
    @pagy, @users = pagy User.all, items: Settings.per_page
  end

  def new
    @user_form = UserForm.new
  end

  def create
    @user_form = UserForm.new user_params
    if @user_form.save
      UserMailer.generate_password(@user_form.user, @user_form.password).deliver_later
      flash[:success] = t ".success"
      redirect_to user_path @user_form.user
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def edit
    @user_form = UserForm.new nil, (User.find params[:id])
  end

  def update
    @user_form = UserForm.new user_params, (User.find params[:id])
    if @user_form.save
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
    else
      flash[:danger] = t ".error"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday, :gender, :phone, :email)
  end

  def find_user
    @user = User.find params[:id]
  end
end
