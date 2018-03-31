class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, except: [:new, :index, :create]
  before_action :verify_admin, only: :destroy

  def index
    @users = User.select(:id, :name, :email, :is_admin).order(:id)
      .paginate page: params[:page], per_page: Settings.user.users_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_mail"
      redirect_to root_path
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_sucess"
      redirect_to users_url
    else
      flash.now[:danger] = t ".delete_failed"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]

    render file: "public/404.html", layout: false unless @user
  end

  def correct_user
    load_user

    redirect_to root_path unless current_user? @user
  end

  def verify_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
