module Dashboard
  class UserSessionsController < ApplicationController
    def destroy
      logout
      flash[:success] = t('.logged_out')
      redirect_to root_path
    end
  end
end
