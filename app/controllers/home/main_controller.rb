module Home
  class MainController < ApplicationController
    skip_before_action :require_login
    def welcome
      redirect_to index_path if current_user
    end
  end
end
