class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      flash[:success] = t ".success"
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      remember user
      redirect_back_or user
    else
      flash.now[:danger] = t ".login_fail"
      render :new
    end
  end

  def destroy
    flash[:success] = t ".logout_success"
    log_out
    redirect_to root_path
  end
end
