class Home::UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_filter :find_user, except: [:new, :create, :index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      flash[:success] = t('.welcome')
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :locale)
  end
end
