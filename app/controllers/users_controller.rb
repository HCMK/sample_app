class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.per_page
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per Settings.mic_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_mail"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]

    return @user if @user
    flash[:warning] = t "no_user"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_path unless current_user?(@user)
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "login_pls"
    redirect_to login_url
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
