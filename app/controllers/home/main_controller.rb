module Home
  class MainController < ApplicationController
    skip_before_action :require_login
    def welcome
      redirect_to review_path if current_user
    end
  end
end
