require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "redirect to login" do
      delete :destroy
      expect(response).to redirect_to login_path
    end
  end
end
