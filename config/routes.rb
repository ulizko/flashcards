Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  scope module: 'dashboard' do
    get 'review' => 'review#index', as: 'review'
    post 'check' => 'review#check'
    resources :cards
    resources :user_sessions, only: :destroy
    resources :users, only: [:edit, :update]
    resources :decks
    delete 'logout' => 'user_sessions#destroy', :as => :logout
  end

  scope module: 'home' do
    root 'main#welcome'
    resources :user_sessions, only: :create
    resources :users, only: [:new, :create]
    get 'login' => 'user_sessions#new', :as => :login
    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback"
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  end
end
