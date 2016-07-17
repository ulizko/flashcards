class Home::UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:success] = t('.login_successful')
      redirect_back_or_to :users
    else
      flash.now[:danger] = t('.login_failed')
      render action: 'new'
    end
  end
end
