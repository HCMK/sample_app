class SessionsController < ApplicationController
  before_action :loaduser, only: :create

  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      if @user.activated?
        log_in @user
        session_remember @user
        redirect_back_or @user
      else
        flash[:warning] = t("not_activated") + t("check_email")
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def loaduser
    @user = User.find_by email: params[:session][:email].downcase
  end

  def session_remember user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
