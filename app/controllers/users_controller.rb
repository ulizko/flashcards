class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_filter :find_user, except: [:new, :create, :index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      flash[:success] = 'Welcome!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end
  def update
    if @user.update(user_params)
      flash[:success] = 'Profile was updated!'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
  end




  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
  def find_user
    @user = User.find(params[:id])
  end
end