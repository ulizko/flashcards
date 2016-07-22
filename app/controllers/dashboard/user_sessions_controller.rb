class Dashboard::UserSessionsController < ApplicationController
  def destroy
    logout
    flash[:successful] = t('.logged_out')
    redirect_to root_path
  end
end
