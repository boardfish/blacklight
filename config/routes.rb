Rails.application.routes.draw do
  resources :escape_games do
    resources :images, only: [:destroy]
  end
  resources :users, except: :index
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
    post 'maintainer', :to => 'users#maintainer', :as => :make_user_maintainer
    post 'enthusiast', :to => 'users#enthusiast', :as => :make_user_enthusiast
    post 'both', :to => 'users#maintainer_and_enthusiast', :as => :make_maintainer_and_enthusiast
  end
end
