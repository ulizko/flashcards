module Home
  class OauthsController < ApplicationController
    skip_before_action :require_login
  
    def oauth
      login_at(params[:provider])
    end
  
    def callback
      provider = params[:provider]
      if @user = login_from(provider)
        redirect_to root_path
        flash[:success] = t('.logged_in_from', provider: provider.titleize)
      else
        begin
          @user = create_from(provider)
          reset_session
          auto_login(@user)
          redirect_to root_path
          flash[:success] = t('.logged_in_from', provider: provider.titleize)
        rescue
          redirect_to root_path
          flash[:danger] = t('.failed_login_from', provider: provider.titleize)
        end
      end
    end
  
    private
  
    def auth_params
      params.permit(:code, :provider)
    end
  end
end
