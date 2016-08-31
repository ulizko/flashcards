module Dashboard
  class UsersController < ApplicationController
    skip_before_action :require_login, only: [:index, :new, :create]
    before_action :find_user, except: [:new, :create, :index]

    def index
      @users = User.all
    end

    def edit
    end

    def update
      if @user.update(user_params)
        flash[:success] = t('.profile_updated')
        redirect_to root_path
      else
        render 'edit'
      end
    end

    def show
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :locale)
    end

    def find_user
      @user = User.find(params[:id])
    end
  end
end
