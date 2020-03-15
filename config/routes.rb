Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/destroy'
  get 'feed/show'
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"

  # get 'auth/auth0/callback' => 'auth0#callback'
  # get 'auth/failure' => 'auth0#failure'

  get 'feed' => 'feed#show'

  devise_for :users, skip: [:sessions], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_in', :to => 'home#index', :as => :new_user_session
    get 'sign_out', :to => 'sessions#destroy', :as => :destroy_user_session
  end
end
